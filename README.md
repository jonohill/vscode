# docker-vscode

Code CLI in a Docker image.

The default entrypoint/command is:
```
code serve-web \
    --host 0.0.0.0 \
    --without-connection-token \
    --accept-server-license-terms
```

Run with `--help` to see the available options.

## Builds

All going well, a new image will be automatically created whenever VS Code is released.
