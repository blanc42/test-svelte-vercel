# Use an official Node.js runtime as the base image
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and go.mod files
COPY package*.json ./
#COPY go.mod go.sum ./

# Install Go dependencies
#RUN go mod download
RUN apt update
RUN apt install -y curl
RUN curl -fsSL https://bun.sh/install | bash
RUN export PATH="~/.bun/bin:$PATH"

# Install Node.js dependencies
RUN ~/.bun/bin/bun install

# Install Vercel CLI globally
RUN ~/.bun/bin/bun install -g vercel

# RUN vercel login --token 9jkOZfuT1T4kBVGk82V2viFg

# Copy the rest of the application code
# COPY . .

# Expose the port Vercel dev runs on (usually 3000)
EXPOSE 5173

# Command to run Vercel dev
CMD ["tail", "-f", "/dev/null"]