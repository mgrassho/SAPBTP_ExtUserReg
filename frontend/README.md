<!--
SPDX-FileCopyrightText: 2022 Martin Grasshoff https://github.com/mgrassho

SPDX-License-Identifier: Apache-2.0
-->

# frontend

This template should help get you started developing with Vue 3 in Vite.

## Recommended IDE Setup

[VSCode](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur) + [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin).

## Type Support for `.vue` Imports in TS

TypeScript cannot handle type information for `.vue` imports by default, so we replace the `tsc` CLI with `vue-tsc` for type checking. In editors, we need [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin) to make the TypeScript language service aware of `.vue` types.

If the standalone TypeScript plugin doesn't feel fast enough to you, Volar has also implemented a [Take Over Mode](https://github.com/johnsoncodehk/volar/discussions/471#discussioncomment-1361669) that is more performant. You can enable it by the following steps:

1. Disable the built-in TypeScript Extension
    1) Run `Extensions: Show Built-in Extensions` from VSCode's command palette
    2) Find `TypeScript and JavaScript Language Features`, right click and select `Disable (Workspace)`
2. Reload the VSCode window by running `Developer: Reload Window` from the command palette.


## Testing

According to the vue home page, cypress [https://cypress.io](cypress.io) is recommended as testing framework for vue applications.

Adding cypress to the project was very comfortable and is described here:
[https://docs.cypress.io/guides/component-testing/vue/overview](cypress.io).

After starting cypress you need an assistent offers you to configure your project. It automatically detects whether your project uses Typescript or not and provides the needed configuration.

Afterwards, you can add your test to the project.
