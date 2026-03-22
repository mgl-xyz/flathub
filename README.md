# flathub hosted remote

This repository hosts the shared Flatpak remote for the `mgl-xyz` applications.
本仓库用于托管 `mgl-xyz` 应用共享的 Flatpak 远程仓库。

## Homepage / 首页

A simple bilingual homepage is published from `public/index.html` for GitHub Pages visitors.
一个简洁的中英双语首页已添加到 `public/index.html`，用于 GitHub Pages 访问入口。

## How to use / 使用方法

### English

1. Open the published site on GitHub Pages.
2. Download `flathub.flatpakrepo` from the homepage.
3. Add the remote with Flatpak:

```bash
flatpak remote-add --if-not-exists mgl-xyz https://mgl-xyz.github.io/flathub/flathub.flatpakrepo
```

4. After the remote is added, install apps from the shared repository.

### 中文

1. 打开部署到 GitHub Pages 的站点。
2. 在首页下载 `flathub.flatpakrepo`。
3. 使用 Flatpak 添加远程仓库：

```bash
flatpak remote-add --if-not-exists mgl-xyz https://mgl-xyz.github.io/flathub/flathub.flatpakrepo
```

4. 添加成功后，即可从共享仓库安装应用。

## Repository responsibilities / 仓库职责

`mgl-xyz/flathub` is responsible for:
`mgl-xyz/flathub` 主要负责：

- storing the exported Flatpak remote content under `repo/`;
- publishing that content to GitHub Pages;
- publishing the Pages site from the `gh-pages` branch;
- generating the shared `.flatpakrepo` descriptor.
- 保存导出的 Flatpak 远程仓库内容到 `repo/`；
- 将这些内容发布到 GitHub Pages；
- 通过 `gh-pages` 分支发布页面站点；
- 生成共享的 `.flatpakrepo` 描述文件。

Once Pages is enabled for the repository and the workflow below runs successfully, the hosted remote URLs are:
当仓库启用 Pages 且下方工作流成功运行后，可使用以下地址：

- Remote repository: `https://mgl-xyz.github.io/flathub/repo/`
- Flatpak repo file: `https://mgl-xyz.github.io/flathub/flathub.flatpakrepo`
- 远程仓库地址：`https://mgl-xyz.github.io/flathub/repo/`
- Flatpak 仓库文件：`https://mgl-xyz.github.io/flathub/flathub.flatpakrepo`

## Expected downstream publisher configuration / 下游发布配置

Both packaging repositories should publish into this hosted remote.
两个打包仓库都应将产物发布到这个托管远程仓库中。

### `mgl-xyz/flatpak-cursor`

This repository should export its release output and push the generated remote artifacts into `mgl-xyz/flathub` using:
该仓库应导出发布产物，并使用以下配置将生成的远程仓库内容推送到 `mgl-xyz/flathub`：

- `FLATPAK_REMOTE_REPOSITORY=mgl-xyz/flathub`
- `FLATPAK_REMOTE_BASE_URL=https://mgl-xyz.github.io/flathub`
- `FLATPAK_REMOTE_TOKEN=<token with push access to mgl-xyz/flathub>`

### `mgl-xyz/flatpak-trae`

This repository already has packaging capability. The next critical step is wiring in the hosted remote publishing configuration so its release workflow pushes artifacts into this repository using:
该仓库已经具备打包能力，下一步重点是接入托管远程仓库发布配置，让其发布流程使用以下参数将产物推送到当前仓库：

- `FLATPAK_REMOTE_REPOSITORY=mgl-xyz/flathub`
- `FLATPAK_REMOTE_BASE_URL=https://mgl-xyz.github.io/flathub`
- `FLATPAK_REMOTE_TOKEN=<token with push access to mgl-xyz/flathub>`

That will make `flatpak-trae` publish into the same shared hosted remote as `flatpak-cursor`.
这样 `flatpak-trae` 就能与 `flatpak-cursor` 一样发布到同一个共享托管远程仓库。

## How Pages publishing works here / Pages 发布流程

1. Packaging repositories push updated Flatpak repository contents into `repo/`.
2. This repository's Pages workflow copies `repo/` into a publish directory.
3. The workflow generates `flathub.flatpakrepo` with the correct GitHub Pages URL.
4. The workflow publishes the result to the `gh-pages` branch.
5. 打包仓库把更新后的 Flatpak 仓库内容推送到 `repo/`。
6. 当前仓库的 Pages 工作流将 `repo/` 复制到发布目录。
7. 工作流根据正确的 GitHub Pages 地址生成 `flathub.flatpakrepo`。
8. 最终结果发布到 `gh-pages` 分支。

## GitHub repository settings / GitHub 仓库设置

Enable the following repository settings in GitHub:
请在 GitHub 中启用以下仓库设置：

1. Turn on **GitHub Pages**.
2. Configure Pages to serve from the **`gh-pages` branch**.
3. Allow GitHub Actions to write to the repository contents.
4. 开启 **GitHub Pages**。
5. 将 Pages 来源设置为 **`gh-pages` 分支**。
6. 允许 GitHub Actions 写入仓库内容。

## Manual generation / 本地生成

You can generate the descriptor locally with:
可以通过下面的命令在本地生成描述文件：

```bash
FLATPAK_REMOTE_BASE_URL=https://mgl-xyz.github.io/flathub \
./scripts/generate-flatpakrepo.sh
```

This writes `public/flathub.flatpakrepo`, which is also what the workflow publishes.
该命令会写入 `public/flathub.flatpakrepo`，这也是工作流最终发布的文件。
