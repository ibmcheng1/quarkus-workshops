#!/usr/bin/env bash
# tag::adocSnippet[]
cd quarkus-workshop-super-heroes/super-heroes
mvn io.quarkus:quarkus-maven-plugin:1.13.0.Final:create \
    -DprojectGroupId=io.quarkus.workshop.super-heroes \
    -DprojectArtifactId=rest-villain \
    -DclassName="io.quarkus.workshop.superheroes.villain.VillainResource" \
    -Dpath="api/villains"
cd rest-villain
./mvnw quarkus:add-extension -Dextensions="jdbc-postgresql,hibernate-orm-panache,hibernate-validator,quarkus-resteasy-jsonb,quarkus-smallrye-openapi,quarkus-smallrye-metrics,quarkus-smallrye-health,com.fasterxml.jackson.core:jackson-databind,org.testcontainers:junit-jupiter:1.15.2,org.testcontainers:postgresql:1.15.2"
# end::adocSnippet[]
