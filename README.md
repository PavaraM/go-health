# go-health

![Go Version](https://img.shields.io/badge/Go-1.27-00ADD8?logo=go)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)
![CI](https://github.com/PavaraM/go-health/actions/workflows/ci.yml/badge.svg)
![License](https://img.shields.io/badge/License-TBD-lightgrey)

A minimal, production-ready HTTP health check server written in Go. Designed for Kubernetes liveness/readiness probes, load balancer health checks, and container orchestration platforms.

## Features

- **Lightweight** — Single binary, ~5 MB (statically linked)
- **Fast** — Minimal overhead, responds in microseconds
- **Container-native** — Multi-stage Docker build (scratch-compatible)
- **Tested** — Unit tests with `httptest`
- **CI/CD** — GitHub Actions pipeline (test, build, docker, integration test)

## Quick Start

### Run locally

```bash
go run main.go
# Server starts on :8080
curl http://localhost:8080/health
# OK
```

### With Docker

```bash
docker build -t go-health .
docker run -d -p 8080:8080 --name go-health go-health
curl http://localhost:8080/health
# OK
```

## API

| Method | Path    | Response | Status |
|--------|---------|----------|--------|
| GET    | `/health` | `OK\n`   | 200    |

## Testing

```bash
# Unit tests
go test ./...

# With coverage
go test -cover ./...
```

## CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/ci.yml`) runs on every push/PR:

1. **Checkout** → **Setup Go 1.27**
2. **Run tests** → `go test ./...`
3. **Build binary** → `go build -o go-health .`
4. **Build Docker image** → `docker build -t go-health .`
5. **Integration test** → Spin container + `curl /health`

## Project Structure

```
.
├── main.go           # HTTP server with /health handler
├── main_test.go      # Unit test for health handler
├── go.mod            # Go module (1.27)
├── Dockerfile        # Multi-stage build (golang:1.27 → alpine)
└── .github/workflows/ci.yml
```

## License

[LICENSE](LICENSE) — *To be decided*