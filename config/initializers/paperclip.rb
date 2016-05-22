# Disable the use of ?querystring in image_tags, eg /restoran/micro/publico-105.jpg?1407748204
# which is not preferred for caching.
Paperclip::Attachment.default_options[:use_timestamp] = false

PPCLIP_APP_ORIGINAL = "500X500>"
PPCLIP_APP_SMALL = "160x160#"
PPCLIP_APP_MEDIUM = "320x"
PPCLIP_APP_BIG = "640x"
