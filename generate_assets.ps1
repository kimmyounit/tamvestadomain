Add-Type -AssemblyName System.Drawing

$srcPath = "C:\Users\ADVAN\.gemini\antigravity\brain\5ecefcad-e928-4e2d-a9bf-189ca81f2b2f\.user_uploaded\media_1792503875579_1c531bdf.jpg"
$resDir = "C:\Users\ADVAN\Downloads\Folder Baru (3)\tamvestafix\android\app\src\main\res"
$srcImg = [System.Drawing.Bitmap]::FromFile($srcPath)

$bgColor = [System.Drawing.Color]::FromArgb(133, 204, 246) # #85CCF6

function Resize-Square([System.Drawing.Image]$img, [int]$size, [string]$outPath) {
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear($bgColor)
    $g.DrawImage($img, 0, 0, $size, $size)
    $g.Dispose()
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

function Resize-Round([System.Drawing.Image]$img, [int]$size, [string]$outPath) {
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)
    
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddEllipse(0, 0, $size, $size)
    $g.SetClip($path)
    $g.DrawImage($img, 0, 0, $size, $size)
    $path.Dispose()
    $g.Dispose()
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

function Resize-Foreground([System.Drawing.Image]$img, [int]$size, [string]$outPath) {
    # Foreground adaptive icon needs about 66% content in center
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)
    
    $contentSize = [int]($size * 0.72)
    $offset = [int](($size - $contentSize) / 2)
    $g.DrawImage($img, $offset, $offset, $contentSize, $contentSize)
    $g.Dispose()
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

function Create-Splash([System.Drawing.Image]$img, [int]$w, [int]$h, [string]$outPath) {
    $bmp = New-Object System.Drawing.Bitmap($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear($bgColor)
    
    # Scale image to fit within width or height preserving aspect ratio
    $scale = [Math]::Min($w / $img.Width, $h / $img.Height) * 0.75
    $targetW = [int]($img.Width * $scale)
    $targetH = [int]($img.Height * $scale)
    $posX = [int](($w - $targetW) / 2)
    $posY = [int](($h - $targetH) / 2)
    
    $g.DrawImage($img, $posX, $posY, $targetW, $targetH)
    $g.Dispose()
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

# 1. Generate Mipmap Icons
$mipmaps = @{
    "mipmap-mdpi" = @{ icon = 48; fg = 108 }
    "mipmap-hdpi" = @{ icon = 72; fg = 162 }
    "mipmap-xhdpi" = @{ icon = 96; fg = 216 }
    "mipmap-xxhdpi" = @{ icon = 144; fg = 324 }
    "mipmap-xxxhdpi" = @{ icon = 192; fg = 432 }
}

foreach ($dir in $mipmaps.Keys) {
    $targetDir = Join-Path $resDir $dir
    if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force }
    $cfg = $mipmaps[$dir]
    
    Resize-Square $srcImg $cfg.icon (Join-Path $targetDir "ic_launcher.png")
    Resize-Round $srcImg $cfg.icon (Join-Path $targetDir "ic_launcher_round.png")
    Resize-Foreground $srcImg $cfg.fg (Join-Path $targetDir "ic_launcher_foreground.png")
}

# 2. Generate Splash Screens
$splashes = @{
    "drawable" = @{ w = 480; h = 800 }
    "drawable-port-mdpi" = @{ w = 320; h = 480 }
    "drawable-port-hdpi" = @{ w = 480; h = 800 }
    "drawable-port-xhdpi" = @{ w = 720; h = 1280 }
    "drawable-port-xxhdpi" = @{ w = 960; h = 1600 }
    "drawable-port-xxxhdpi" = @{ w = 1280; h = 1920 }
    "drawable-land-mdpi" = @{ w = 480; h = 320 }
    "drawable-land-hdpi" = @{ w = 800; h = 480 }
    "drawable-land-xhdpi" = @{ w = 1280; h = 720 }
    "drawable-land-xxhdpi" = @{ w = 1600; h = 960 }
    "drawable-land-xxxhdpi" = @{ w = 1920; h = 1280 }
}

foreach ($dir in $splashes.Keys) {
    $targetDir = Join-Path $resDir $dir
    if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force }
    $cfg = $splashes[$dir]
    Create-Splash $srcImg $cfg.w $cfg.h (Join-Path $targetDir "splash.png")
}

$srcImg.Dispose()
"Assets generated successfully!"
