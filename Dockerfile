FROM swift:5.9-focal as builder
WORKDIR /app
COPY backend ./backend
WORKDIR /app/backend
RUN swift build --configuration release

FROM swift:5.9-focal-slim
WORKDIR /app
COPY --from=builder /app/backend/.build/release/Run .
EXPOSE 8080
ENV PORT=8080
CMD ["./Run", "serve", "--hostname", "0.0.0.0", "--port", "8080", "--env", "production"]
