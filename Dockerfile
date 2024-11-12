ARG BUILDER_IMAGE=has_to_be_provided
ARG DISTROLESS_IMAGE=has_to_be_provided

FROM ${BUILDER_IMAGE} AS build
WORKDIR /app
COPY Cargo.toml Cargo.lock /app
COPY src /app/src
RUN cargo build --release

FROM ${DISTROLESS_IMAGE}
COPY --from=build /app/target/release/telegram-birthday-reminder-bot /
CMD ["./telegram-birthday-reminder-bot"]
