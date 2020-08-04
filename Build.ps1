[cmdletbinding()]
param(
    [switch]$Push,
    [version]$Version = "1.6.1.0"
)

$env:MINECRAFT_VERSION = $Version
docker pull ubuntu:bionic
docker pull docker.pkg.github.com/foreshot/minecraft-bedrock/package:${env:MINECRAFT_VERSION}
docker pull docker.pkg.github.com/foreshot/minecraft-bedrock/server:${env:MINECRAFT_VERSION}
docker-compose --log-level INFO build

if ($Push) {
    docker-compose push
    docker tag docker.pkg.github.com/foreshot/minecraft-bedrock/server:${env:MINECRAFT_VERSION} foreshot/minecraft-bedrock:${env:MINECRAFT_VERSION}
    docker push foreshot/minecraft-bedrock:${env:MINECRAFT_VERSION}
}