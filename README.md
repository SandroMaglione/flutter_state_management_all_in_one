# `Best Flutter State management`
<p>
  <a href="https://github.com/SandroMaglione">
    <img alt="GitHub: SandroMaglione" src="https://img.shields.io/github/followers/SandroMaglione?label=Follow&style=social" target="_blank" />
  </a>
  <a href="https://twitter.com/SandroMaglione">
    <img alt="Twitter: SandroMaglione" src="https://img.shields.io/twitter/follow/SandroMaglione.svg?style=social" target="_blank" />
  </a>
</p>

***

This project is part of my weekly newsletter at [**sandromaglione.com**](https://www.sandromaglione.com/newsletter?ref=Github&utm_medium=newsletter_project&utm_term=flutter).


<a href="https://www.sandromaglione.com/newsletter?ref=Github&utm_medium=newsletter_project&utm_term=flutter">
    <img alt="sandromaglione.com Newsletter weekly project" src="https://www.sandromaglione.com/static/images/newsletter_banner.webp" target="_blank" /> 
</a>

## Project structure 🔜

### `bloc`
- Issues with missing providers
```dart
/// This was broken because the type was inferred as [GridSettingsDefault]
RepositoryProvider(
  create: (context) => const GridSettingsDefault(),
)

///                👇 This is required
RepositoryProvider<GridSettings>(
  create: (context) => const GridSettingsDefault(),
)
```
- Need to nest `RepositoryProvider` when one repository depends on another