///|
#external
type ImageDataSettings

///|
pub extern "js" fn ImageDataSettings::new(
  color_space : PredefinedColorSpace
) -> ImageDataSettings = "(colorSpace) => ({colorSpace: colorSpace})"
