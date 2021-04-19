#!/usr/bin/env bash
# tag::adocSnippet[]
cd quarkus-workshop-super-heroes/super-heroes
mvn io.quarkus:quarkus-maven-plugin:1.13.0.Final:create \
    -DprojectGroupId=io.quarkus.workshop.super-heroes \
    -DprojectArtifactId=rest-fight \
    -DclassName="io.quarkus.workshop.superheroes.fight.FightResource" \
    -Dpath="api/fights"
cd rest-fight
./mvnw quarkus:add-extension -Dextensions="jdbc-postgresql,hibernate-orm-panache,hibernate-validator,quarkus-resteasy-jsonb,quarkus-smallrye-openapi,quarkus-smallrye-metrics,quarkus-smallrye-health,quarkus-smallrye-reactive-messaging-kafka,smallrye-fault-tolerance,com.fasterxml.jackson.core:jackson-databind,org.testcontainers:junit-jupiter:1.15.2,org.testcontainers:postgresql:1.15.2,com.fasterxml.jackson.datatype:jackson-datatype-jsr310,org.testcontainers:kafka,org.scala-lang:scala-library"
# end::adocSnippet[]
