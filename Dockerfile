# Install flutter
FROM haizen/flutter:2.10.2-1-alpine AS build-env

# Run flutter doctor and enable web
RUN flutter doctor
RUN flutter config --enable-web

# Copy files to container and build
USER root
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web --dart-define=API_URL=http://api.aparcam.tk
# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html