from moviepy import ImageClip, concatenate_videoclips
from pathlib import Path

# Get all images from the images folder
image_folder = Path("images")
image_files = sorted(image_folder.glob("*")) 

clips = []
for img_path in image_files:
    clip = ImageClip(str(img_path)).resized((1920,1070)).with_duration(1.83)
    clips.append(clip)

final = concatenate_videoclips(clips)
final.write_videofile("videos/test_movie.mp4", fps=24)

print(f"Done! Created video with {len(clips)} images.")
