group "default" {
    targets = ["superset"]
}

target "superset" {
    context = "./"
    dockerfile = "Dockerfile"
    platforms = ["linux/amd64", "linux/arm64"]
    tags = ["535710392721.dkr.ecr.us-west-2.amazonaws.com/superset:latest"]
}

