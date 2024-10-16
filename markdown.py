from bs4 import BeautifulSoup
import base64
import os

# Parse HTML
with open('/home/akugyo/GitHub/bills/2024/file.html', 'r') as f:
    soup = BeautifulSoup(f, 'html.parser')

# Find image tags
images = soup.find_all('img')

# Update image tags with Base64 encoded images
for img in images:
    img_url = img.get('src')
    
    # Remove leading slash or file protocol
    # if img_url.startswith('/'):
    #     img_url = img_url[1:]
    # if img_url.startswith('file://'):
    #     img_url = img_url[7:]
    
    # Read image file
    with open(img_url, 'rb') as image_file:
        image_data = image_file.read()
        
    # Base64 encode image
    encoded_image = base64.b64encode(image_data).decode('utf-8')
    
    # Update image tag with Base64 encoded image
    img['src'] = f'data:image/{img_url.split(".")[-1]};base64,{encoded_image}'

# Save updated HTML
with open('13.html', 'w') as f:
    f.write(str(soup))