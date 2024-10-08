![](https://img.shields.io/badge/Built%20with%20%E2%9D%A4%EF%B8%8F-at%20Technologiestiftung%20Berlin-blue)

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)

<!-- ALL-CONTRIBUTORS-BADGE:END -->

> Note: This project is part of the [Baumblick](https://github.com/technologiestiftung/baumblick-frontend) application, which is in demo mode since 2024-07-01. The tileserver implemented in this repository is therefore shut down.

# QTrees Vector Tiles Generator

This project is a pipeline to generate vector tiles based on a PGSQL Database. It uses gdal, tippecanoe and mbtileserver to generate and serve vector tiles. It is a part of the QTrees.ai project.

The pipeline consist of three parts. The

1. The base image [Dockerfile.base](./Dockerfile.base) installs all the dependencies and tools needed to generate the vector tiles and serve them
2. The generator.sh step in a GitHub Action [generate.yml](./.github/workflows/generate.yml) generates the vector tiles and pushes them to a S3 bucket (uses the base image)
3. The tileserver hosted on render.com. [Dockerfile.server](./Dockerfile.server) builds a docker image that downloads the generated .pbf from AWS S3 and serves the vector tiles (uses the base image)

## Prerequisites

- Docker
- Postgres DB (also included in docker-compose.override.yml)
- render.com Account
- AWS S3 Bucket

## Usage and Development

Local development is hard when trying to build ci pipelines. Happens mostly in the cloud on GitHub Actions. You could try [nektos/act](https://github.com/nektos/act) to run this locally.

```bash
cd path/to/repo
docker compose up -d
```

## Tests

Currently the tests only check if the images can be built and if the `mbtileserver` can be started.

```bash
cd path/to/repo
docker-compose up -f docker-compose.yml -f docker-compose.test.yml
```

## Credits

<table>
  <tr>
    <td>
      Made by <a src="https://citylab-berlin.org/de/start/">
        <br />
        <br />
        <img width="200" src="https://citylab-berlin.org/wp-content/uploads/2021/05/citylab-logo.svg" />
      </a>
    </td>
    <td>
      A project by <a src="https://www.technologiestiftung-berlin.de/">
        <br />
        <br />
        <img width="150" src="https://citylab-berlin.org/wp-content/uploads/2021/05/tsb.svg" />
      </a>
    </td>
    <td>
      Supported by <a src="https://www.berlin.de/rbmskzl/">
        <br />
        <br />
        <img width="80" src="https://citylab-berlin.org/wp-content/uploads/2021/12/B_RBmin_Skzl_Logo_DE_V_PT_RGB-300x200.png" />
      </a>
    </td>
  </tr>
</table>

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://fabianmoronzirfas.me"><img src="https://avatars.githubusercontent.com/u/315106?v=4?s=128" width="128px;" alt=""/><br /><sub><b>Fabian Morón Zirfas</b></sub></a><br /><a href="https://github.com/technologiestiftung/qtrees-vectortiles/commits?author=ff6347" title="Code">💻</a> <a href="#design-ff6347" title="Design">🎨</a> <a href="#ideas-ff6347" title="Ideas, Planning, & Feedback">🤔</a> <a href="#infra-ff6347" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/technologiestiftung/qtrees-vectortiles/commits?author=ff6347" title="Tests">⚠️</a></td>
    <td align="center"><a href="https://www.technologiestiftung-berlin.de/de/citylab/"><img src="https://avatars.githubusercontent.com/u/91873654?v=4?s=128" width="128px;" alt=""/><br /><sub><b>juan-carlos-tsb</b></sub></a><br /><a href="https://github.com/technologiestiftung/qtrees-vectortiles/commits?author=juan-carlos-tsb" title="Code">💻</a> <a href="#design-juan-carlos-tsb" title="Design">🎨</a> <a href="https://github.com/technologiestiftung/qtrees-vectortiles/pulls?q=is%3Apr+reviewed-by%3Ajuan-carlos-tsb" title="Reviewed Pull Requests">👀</a> <a href="#ideas-juan-carlos-tsb" title="Ideas, Planning, & Feedback">🤔</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

<!-- bump version -->
<!-- touch -->
