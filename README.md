<img align="right" src="Sketch/Clipinio.png">

# Clipinio

Lightweight clipboard manager for OS X.

## Usage

Press `CMD` + `C` to copy, and `CMD` + `SHIFT` + `V` to insert a clip via Clipinio. The hotkeys are hardcoded. If demanded, I will add a menu for customizing the keys.

## Build

```bash
sh build.sh
```

It automatically copies Clipinio to `/Applications/Clipinio.app`. Enjoy!

## Additional information

> I used to utilise ClipMenu as daily clipboard manager. As the recent version lacks of access to the source code I decided to switch. Thus, I bought two clipboard managers from the App Store. Both did not work as expected...so I wrote my own implementation of a lightweight clipboard manager. It has been written in Swift as an introduction. This is nothing real special...just fits my daily use case. If anyone cares: I did not invoke the old carbon api as it felt unswifty implementing it. The disadvantage of this approach is that one is not able to consume hotkey events but to receive a copy of these. Meaning the hotkey event is dispatched to the current application.

### Update 2015-12-10

> As of now I am using the old Carbon API, hence being able to consume the events. It is also much faster now and feels more like the old ClipMenu. It was also not that unswifty to implement.
