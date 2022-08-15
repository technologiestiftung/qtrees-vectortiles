![](https://img.shields.io/badge/Built%20with%20%E2%9D%A4%EF%B8%8F-at%20Technologiestiftung%20Berlin-blue)

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)

<!-- ALL-CONTRIBUTORS-BADGE:END -->

# QTrees Vector Tiles Generator

This project is a pipeline to generate vector tiles based on a PGSQL Database. It uses gdal, tippecanoe and mbtileserver to generate and serve vector tiles. It is a part of the QTrees.ai project.

## Prerequisites

- Docker
- Postgres DB (also included in docker-compose.override.yml)

## Usage and Development

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
    <td align="center"><a href="https://fabianmoronzirfas.me"><img src="https://avatars.githubusercontent.com/u/315106?v=4?s=128" width="128px;" alt=""/><br /><sub><b>Fabian Morón Zirfas</b></sub></a><br /><a href="https://github.com/technologiestiftung/qtrees-vectortiles-generator/commits?author=ff6347" title="Code">💻</a> <a href="#design-ff6347" title="Design">🎨</a> <a href="#ideas-ff6347" title="Ideas, Planning, & Feedback">🤔</a> <a href="#infra-ff6347" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/technologiestiftung/qtrees-vectortiles-generator/commits?author=ff6347" title="Tests">⚠️</a></td>
    <td align="center"><a href="https://www.technologiestiftung-berlin.de/de/citylab/"><img src="https://avatars.githubusercontent.com/u/91873654?v=4?s=128" width="128px;" alt=""/><br /><sub><b>juan-carlos-tsb</b></sub></a><br /><a href="https://github.com/technologiestiftung/qtrees-vectortiles-generator/commits?author=juan-carlos-tsb" title="Code">💻</a> <a href="#design-juan-carlos-tsb" title="Design">🎨</a> <a href="https://github.com/technologiestiftung/qtrees-vectortiles-generator/pulls?q=is%3Apr+reviewed-by%3Ajuan-carlos-tsb" title="Reviewed Pull Requests">👀</a> <a href="#ideas-juan-carlos-tsb" title="Ideas, Planning, & Feedback">🤔</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

<!-- bump version -->
