# flathub hosted remote

This repository hosts the shared Flatpak remote for the `mgl-xyz` applications.

## Repository responsibilities

`mgl-xyz/flathub` is responsible for:

- storing the exported Flatpak remote content under `repo/`;
- publishing that content to GitHub Pages;
- publishing the Pages site from the `gh-pages` branch;
- generating the shared `.flatpakrepo` descriptor.

Once Pages is enabled for the repository and the workflow below runs successfully, the hosted remote URLs are:

- Remote repository: `https://mgl-xyz.github.io/flathub/repo/`
- Flatpak repo file: `https://mgl-xyz.github.io/flathub/flathub.flatpakrepo`

## Expected downstream publisher configuration

Both packaging repositories should publish into this hosted remote.

### `mgl-xyz/flatpak-cursor`

This repository should export its release output and push the generated remote artifacts into `mgl-xyz/flathub` using:

- `FLATPAK_REMOTE_REPOSITORY=mgl-xyz/flathub`
- `FLATPAK_REMOTE_BASE_URL=https://mgl-xyz.github.io/flathub`
- `FLATPAK_REMOTE_TOKEN=<token with push access to mgl-xyz/flathub>`

### `mgl-xyz/flatpak-trae`

This repository already has packaging capability. The next critical step is wiring in the hosted remote publishing configuration so its release workflow pushes artifacts into this repository using:

- `FLATPAK_REMOTE_REPOSITORY=mgl-xyz/flathub`
- `FLATPAK_REMOTE_BASE_URL=https://mgl-xyz.github.io/flathub`
- `FLATPAK_REMOTE_TOKEN=<token with push access to mgl-xyz/flathub>`

That will make `flatpak-trae` publish into the same shared hosted remote as `flatpak-cursor`.

## How Pages publishing works here

1. Packaging repositories push updated Flatpak repository contents into `repo/`.
2. This repository's Pages workflow copies `repo/` into a publish directory.
3. The workflow generates `flathub.flatpakrepo` with the correct GitHub Pages URL.
4. The workflow publishes the result to the `gh-pages` branch.

## GitHub repository settings

Enable the following repository settings in GitHub:

1. Turn on **GitHub Pages**.
2. Configure Pages to serve from the **`gh-pages` branch**.
3. Allow GitHub Actions to write to the repository contents.

## Manual generation

You can generate the descriptor locally with:

```bash
FLATPAK_REMOTE_BASE_URL=https://mgl-xyz.github.io/flathub \
./scripts/generate-flatpakrepo.sh
```

This writes `public/flathub.flatpakrepo`, which is also what the workflow publishes.
