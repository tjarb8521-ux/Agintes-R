import { run as runTui, type TuiInput } from "@agintes-ai/tui"
import { Global } from "@agintes-ai/core/global"
import { AppNodeBuilder } from "@agintes-ai/core/effect/app-node-builder"
import { Effect } from "effect"

export function run(input: TuiInput) {
  return runTui(input).pipe(Effect.provide(AppNodeBuilder.build(Global.node)))
}
