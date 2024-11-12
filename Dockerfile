FROM rust:1.81 AS build
WORKDIR /app
COPY Cargo.toml Cargo.lock /app
COPY src /app/src
RUN cargo build --release

FROM gcr.io/distroless/cc-debian12
COPY --from=build /app/target/release/telegram-birthday-reminder-bot /
CMD ["./telegram-birthday-reminder-bot"]
