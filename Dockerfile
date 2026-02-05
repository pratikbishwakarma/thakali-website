# Use the official nginx image as the base image
FROM nginx:alpine

# Copy the HTML file to the nginx html directory
COPY thakali-website.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]