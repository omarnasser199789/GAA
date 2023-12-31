FROM node:17

# working Dir
WORKDIR /app

# Copy Package Json Files
COPY package*.json ./

# Install Prettier (For our package's build function)
RUN npm install prisma

# Install Files
RUN npm install

# Copy Source Files
COPY . .

ENV PORT=3100

# Build
RUN npm start


# Expose the API Port
EXPOSE 3100

CMD [ "node", "start" ]