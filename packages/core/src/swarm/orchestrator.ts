import { Effect, Schema, DateTime } from "effect"
import { AgentV2 } from "../agent"
import { EventV2 } from "../event"
import { LLMClient } from "@agintes-ai/llm"
import { LLM } from "@agintes-ai/llm"
import { SessionSchema } from "../session/schema"
import { SessionMessage } from "../session/message"
import { SessionEvent } from "../session/event"

export const SwarmTaskSchema = Schema.Struct({
  id: Schema.String,
  role: Schema.Literals(["planner", "coder", "reviewer"]),
  description: Schema.String,
})

export const SwarmPlanSchema = Schema.Struct({
  goal: Schema.String,
  tasks: Schema.Array(SwarmTaskSchema),
})

/**
 * Agintes R - Swarm Orchestrator
 * This service sits between the User Prompt and the LLM execution.
 */
export const executeSwarm = Effect.fn("Agintes.executeSwarm")(function* (
  sessionID: SessionSchema.ID,
  promptText: string
) {
  const events = yield* EventV2.Service

  const pushMessage = (role: "assistant", text: string) => Effect.gen(function*() {
      const ts = yield* DateTime.now
      yield* events.publish(SessionEvent.Synthetic, {
        sessionID,
        timestamp: ts,
        message: {
          id: SessionMessage.ID.create(),
          type: "assistant",
          content: [{ type: "text", text }]
        }
      })
  })

  // 1. Planning Phase
  yield* pushMessage("assistant", "🧩 **[Agintes Planner]** Analyzing task and creating a swarm plan...")
  
  const planResponse = yield* LLM.generateObject({
    model: { provider: "openai", id: "gpt-4o" } as any, // Will be made dynamic
    system: "You are the Planner. Break down the user's request into specific tasks.",
    prompt: promptText,
    schema: SwarmPlanSchema,
  })

  const plan = planResponse.object
  const planText = plan.tasks.map(t => `- **${t.role}**: ${t.description}`).join('\n')
  yield* pushMessage("assistant", `📋 **[Agintes Planner]** Plan Generated:\n${planText}`)

  // 2. Delegation & Execution Phase
  for (const task of plan.tasks) {
    yield* pushMessage("assistant", `🚀 **[Agintes Orchestrator]** Delegating to **${task.role}**...`)
    
    let subAgentSystemPrompt = ""
    if (task.role === "coder") {
       subAgentSystemPrompt = "You are the Coder. Write excellent, bug-free code."
    } else if (task.role === "reviewer") {
       subAgentSystemPrompt = "You are the Reviewer. Check the code for security and performance issues."
    }

    try {
      const taskResult = yield* LLM.generate({
        model: { provider: task.role === "coder" ? "anthropic" : "openai", id: "default" } as any,
        system: subAgentSystemPrompt,
        prompt: `Task: ${task.description}`,
      })
      yield* pushMessage("assistant", `✅ **[Agintes ${task.role}]** Task Completed:\n\n${taskResult.content}`)
    } catch(e: any) {
      yield* pushMessage("assistant", `❌ **[Agintes ${task.role}]** Task Failed: ${e.message}`)
    }
  }

  yield* pushMessage("assistant", "🎉 **[Agintes Orchestrator]** All swarm tasks completed successfully.")
  return "Swarm execution completed successfully."
})
