# Stage 1: Build the Angular app
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# RUN npm install --legacy-peer-deps

# RUN npx ngcc --properties es2023 browser module main --first-only --create-ivy-entry-points


RUN npm run build --prod

# Stage 2: Serve the Angular app using Nginx
FROM nginx:alpine

# Copy the custom NGINX configuration file
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy built Angular app from the build stage
COPY --from=build /app/dist/angular-sample-app/browser/* /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]



# FROM node:22.5.1-alpine AS build

# WORKDIR /app

# #COPY ./Frontend/package*.json ./
# COPY ./package*.json ./

# RUN npm install --legacy-peer-deps

# RUN npx ngcc --properties es2023 browser module main --first-only --create-ivy-entry-points

# #COPY ./Frontend/ ./
# COPY . .

# RUN npm run build

# FROM nginx:stable

# COPY default.conf /etc/nginx/conf.d/default.conf
# COPY --from=build /app/dist/client /usr/share/nginx/html

# EXPOSE 80
