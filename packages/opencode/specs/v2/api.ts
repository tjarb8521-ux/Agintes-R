// @ts-nocheck

import { Agintes } from "@agintes-ai/core"
import { ReadTool } from "@agintes-ai/core/tools"

const agintes = Agintes.make({})

agintes.tool.add(ReadTool)

agintes.tool.add({
  name: "bash",
  schema: {
    type: "object",
    properties: {
      command: {
        type: "string",
        description: "The command to run.",
      },
    },
    required: ["command"],
  },
  execute(input, ctx) {},
})

agintes.auth.add({
  provider: "openai",
  type: "api",
  value: process.env.OPENAI_API_KEY,
})

agintes.agent.add({
  name: "build",
  permissions: [],
  model: {
    id: "gpt-5-5",
    provider: "openai",
    variant: "xhigh",
  },
})

const sessionID = await agintes.session.create({
  agent: "build",
})

agintes.subscribe((event) => {
  console.log(event)
})

await agintes.session.prompt({
  sessionID,
  text: "hey what is up",
})

await agintes.session.prompt({
  sessionID,
  text: "what is up with this",
  files: [
    {
      mime: "image/png",
      uri: "data:image/png;base64,xxxx",
    },
  ],
})

await agintes.session.wait()

console.log(await agintes.session.messages(sessionID))
