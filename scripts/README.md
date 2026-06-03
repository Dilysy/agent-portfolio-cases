# Screenshot and Recording Scripts

These scripts are for collecting local demo materials for the Agent portfolio. They do not upload any files.

## Grant Permission

Make the scripts executable:

```bash
chmod +x scripts/capture_screenshot.sh scripts/record_screen.sh
```

macOS may ask for Screen Recording permission the first time you run `screencapture`. If prompted, grant permission in:

```text
System Settings -> Privacy & Security -> Screen & System Audio Recording
```

Then rerun the script.

## Take A Screenshot

Use interactive area screenshot mode:

```bash
scripts/capture_screenshot.sh assets/screenshots/autoflow-home.png
```

After pressing Enter, select the screen area with the mouse.

## Record Screen

Record for the default 60 seconds:

```bash
scripts/record_screen.sh assets/demos/autoflow-demo.mov
```

Record for a custom duration:

```bash
scripts/record_screen.sh assets/demos/autoflow-demo.mov 30
```

The recording starts after a 3-second countdown. macOS `screencapture` does not record system audio.

## Privacy Checklist

Before every screenshot or recording, check that the screen does not show:

- API keys, tokens, or `.env` files
- Account names, private browser pages, phone numbers, addresses, or payment information
- WeChat, email, private messages, or notifications
- Desktop files, downloads, terminal output, or browser tabs containing private information
