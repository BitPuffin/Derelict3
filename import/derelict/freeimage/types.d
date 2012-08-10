/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.freeimage.types;

private import core.stdc.config;

enum FREEIMAGE_MAJOR_VERSION = 3,
     FREEIMAGE_MINOR_VERSION = 15,
     FREEIMAGE_RELEASE_SERIAL = 3;

enum FREEIMAGE_COLORORDER_BGR = 0,
     FREEIMAGE_COLORORDER_RGB = 1;

version(LittleEndian)
{
    version = FREEIMAGE_COLORORDER_BGR;
}
else
{
    version = FREEIMAGE_COLORORDER_RGB;
}


// Bitmap types -------------------------------------------------------------

struct FIBITMAP
{
    void *data;
}

struct FIMULTIBITMAP
{
    void *data;
}

enum FALSE = 0,
     TRUE = 1,
     NULL = 0;

enum
{
    SEEK_SET = 0,
    SEEK_CUR = 1,
    SEEK_END = 2
}

alias uint BOOL;
alias ubyte BYTE;
alias ushort WORD;
alias c_ulong DWORD;
alias int LONG;
alias long FIINT64;
alias ulong FIUINT64;
alias ushort wchar_t; // is wchar_t 2 bytes everywhere?

align(1) struct RGBQUAD
{
    version(FREEIMAGE_COLORORDER_BGR)
    {
        BYTE rgbBlue;
        BYTE rgbGreen;
        BYTE rgbRed;
    }
    else
    {
        BYTE rgbRed;
        BYTE rgbGreen;
        BYTE rgbBlue;
    }
    BYTE rgbReserved;
}

align(1) struct RGBTRIPLE
{
    version(FREEIMAGE_COLORORDER_BGR)
    {
        BYTE rgbtBlue;
        BYTE rgbtGreen;
        BYTE rgbtRed;
    }
    else
    {
        BYTE rgbtRed;
        BYTE rgbtGreen;
        BYTE rgbtBlue;
    }
}

align(1) struct BITMAPINFOHEADER
{
    DWORD biSize;
    LONG  biWidth;
    LONG  biHeight;
    WORD  biPlanes;
    WORD  biBitCount;
    DWORD biCompression;
    DWORD biSizeImage;
    LONG  biXPelsPerMeter;
    LONG  biYPelsPerMeter;
    DWORD biClrUsed;
    DWORD biClrImportant;
}

alias BITMAPINFOHEADER* PBITMAPINFOHEADER;

align(1) struct BITMAPINFO
{
    BITMAPINFOHEADER bmiHeader;
    RGBQUAD          bmiColors[1];
}

alias BITMAPINFO* PBITMAPINFO;

// Types used in the library (specific to FreeImage) ------------------------

/** 48-bit RGB
*/
align(1) struct FIRGB16
{
    WORD red;
    WORD green;
    WORD blue;
}

/** 64-bit RGBA
*/
align(1) struct FIRGBA16
{
    WORD red;
    WORD green;
    WORD blue;
    WORD alpha;
}

/** 96-bit RGB Float
*/
align(1) struct FIRGBF
{
    float red;
    float green;
    float blue;
}

/** 128-bit RGBA Float
*/
align(1) struct FIRGBAF
{
    float red;
    float green;
    float blue;
    float alpha;
}

/** Data structure for COMPLEX type (complex number)
*/
align(1) struct FICOMPLEX
{
    /// real part
    double r;
    /// imaginary part
    double i;
}

// Handle to a metadata model
struct FIMETADATA
{
    void* data;
}

// Handle to a FreeImage tag
struct FITAG
{
    void* data;
}


// Indexes for byte arrays, masks and shifts for treating pixels as words ---
// These coincide with the order of RGBQUAD and RGBTRIPLE -------------------

version(LittleEndian)
{
    version(FREEIMAGE_COLORORDER_BGR)
    {
        // Little Endian (x86 / MS Windows, Linux) : BGR(A) order
        enum
        {
            FI_RGBA_RED           = 2,
            FI_RGBA_GREEN         = 1,
            FI_RGBA_BLUE          = 0,
            FI_RGBA_ALPHA         = 3,
            FI_RGBA_RED_MASK      = 0x00FF0000,
            FI_RGBA_GREEN_MASK    = 0x0000FF00,
            FI_RGBA_BLUE_MASK     = 0x000000FF,
            FI_RGBA_ALPHA_MASK    = 0xFF000000,
            FI_RGBA_RED_SHIFT     = 16,
            FI_RGBA_GREEN_SHIFT   = 8,
            FI_RGBA_BLUE_SHIFT    = 0,
            FI_RGBA_ALPHA_SHIFT   = 24
        }
    }
    else
    {
        // Little Endian (x86 / MaxOSX) : RGB(A) order
        enum
        {
            FI_RGBA_RED           = 0,
            FI_RGBA_GREEN         = 1,
            FI_RGBA_BLUE          = 2,
            FI_RGBA_ALPHA         = 3,
            FI_RGBA_RED_MASK      = 0x000000FF,
            FI_RGBA_GREEN_MASK    = 0x0000FF00,
            FI_RGBA_BLUE_MASK     = 0x00FF0000,
            FI_RGBA_ALPHA_MASK    = 0xFF000000,
            FI_RGBA_RED_SHIFT     = 0,
            FI_RGBA_GREEN_SHIFT   = 8,
            FI_RGBA_BLUE_SHIFT    = 16,
            FI_RGBA_ALPHA_SHIFT   = 24
        }
    }
}
else
{
    version(FREEIMAGE_COLORORDER_BGR)
    {
        // Big Endian (PPC / none) : BGR(A) order
        enum
        {
            FI_RGBA_RED           = 2,
            FI_RGBA_GREEN         = 1,
            FI_RGBA_BLUE          = 0,
            FI_RGBA_ALPHA         = 3,
            FI_RGBA_RED_MASK      = 0x0000FF00,
            FI_RGBA_GREEN_MASK    = 0x00FF0000,
            FI_RGBA_BLUE_MASK     = 0xFF000000,
            FI_RGBA_ALPHA_MASK    = 0x000000FF,
            FI_RGBA_RED_SHIFT     = 8,
            FI_RGBA_GREEN_SHIFT   = 16,
            FI_RGBA_BLUE_SHIFT    = 24,
            FI_RGBA_ALPHA_SHIFT   = 0
        }
    }
    else
    {
        // Big Endian (PPC / Linux, MaxOSX) : RGB(A) order
        enum
        {
            FI_RGBA_RED           = 0,
            FI_RGBA_GREEN         = 1,
            FI_RGBA_BLUE          = 2,
            FI_RGBA_ALPHA         = 3,
            FI_RGBA_RED_MASK      = 0xFF000000,
            FI_RGBA_GREEN_MASK    = 0x00FF0000,
            FI_RGBA_BLUE_MASK     = 0x0000FF00,
            FI_RGBA_ALPHA_MASK    = 0x000000FF,
            FI_RGBA_RED_SHIFT     = 24,
            FI_RGBA_GREEN_SHIFT   = 16,
            FI_RGBA_BLUE_SHIFT    = 8,
            FI_RGBA_ALPHA_SHIFT   = 0
        }
    }
}

enum FI_RGBA_RGB_MASK = FI_RGBA_RED_MASK | FI_RGBA_GREEN_MASK | FI_RGBA_BLUE_MASK;

// The 16bit macros only include masks and shifts, since each color element is not byte aligned
enum
{
    FI16_555_RED_MASK     = 0x7C00,
    FI16_555_GREEN_MASK   = 0x03E0,
    FI16_555_BLUE_MASK    = 0x001F,
    FI16_555_RED_SHIFT    = 10,
    FI16_555_GREEN_SHIFT  = 5,
    FI16_555_BLUE_SHIFT   = 0,
    FI16_565_RED_MASK     = 0xF800,
    FI16_565_GREEN_MASK   = 0x07E0,
    FI16_565_BLUE_MASK    = 0x001F,
    FI16_565_RED_SHIFT    = 11,
    FI16_565_GREEN_SHIFT  = 5,
    FI16_565_BLUE_SHIFT   = 0
}

// ICC profile support ------------------------------------------------------

enum
{
    FIICC_DEFAULT       = 0x00,
    FIICC_COLOR_IS_CMYK = 0x01
}

struct FIICCPROFILE
{
    WORD  flags;    // info flag
    DWORD  size;    // profile's size measured in bytes
    void  *data;    // points to a block of contiguous memory containing the profile
}

// Important enums ----------------------------------------------------------

/** I/O image format identifiers.
*/
alias int FREE_IMAGE_FORMAT;
enum : FREE_IMAGE_FORMAT
{
    FIF_UNKNOWN = -1,
    FIF_BMP     = 0,
    FIF_ICO     = 1,
    FIF_JPEG    = 2,
    FIF_JNG     = 3,
    FIF_KOALA   = 4,
    FIF_LBM     = 5,
    FIF_IFF     = FIF_LBM,
    FIF_MNG     = 6,
    FIF_PBM     = 7,
    FIF_PBMRAW  = 8,
    FIF_PCD     = 9,
    FIF_PCX     = 10,
    FIF_PGM     = 11,
    FIF_PGMRAW  = 12,
    FIF_PNG     = 13,
    FIF_PPM     = 14,
    FIF_PPMRAW  = 15,
    FIF_RAS     = 16,
    FIF_TARGA   = 17,
    FIF_TIFF    = 18,
    FIF_WBMP    = 19,
    FIF_PSD     = 20,
    FIF_CUT     = 21,
    FIF_XBM     = 22,
    FIF_XPM     = 23,
    FIF_DDS     = 24,
    FIF_GIF     = 25,
    FIF_HDR     = 26,
    FIF_FAXG3   = 27,
    FIF_SGI     = 28,
    FIF_EXR     = 29,
    FIF_J2K     = 30,
    FIF_JP2     = 31,
    FIF_PFM     = 32,
    FIF_PICT    = 33,
    FIF_RAW     = 34
}

/** Image type used in FreeImage.
*/
alias int FREE_IMAGE_TYPE;
enum : FREE_IMAGE_TYPE
{
    FIT_UNKNOWN = 0,    // unknown type
    FIT_BITMAP  = 1,    // standard image           : 1-, 4-, 8-, 16-, 24-, 32-bit
    FIT_UINT16  = 2,    // array of unsigned short  : unsigned 16-bit
    FIT_INT16   = 3,    // array of short           : signed 16-bit
    FIT_UINT32  = 4,    // array of unsigned long   : unsigned 32-bit
    FIT_INT32   = 5,    // array of long            : signed 32-bit
    FIT_FLOAT   = 6,    // array of float           : 32-bit IEEE floating point
    FIT_DOUBLE  = 7,    // array of double          : 64-bit IEEE floating point
    FIT_COMPLEX = 8,    // array of FICOMPLEX       : 2 x 64-bit IEEE floating point
    FIT_RGB16   = 9,    // 48-bit RGB image         : 3 x 16-bit
    FIT_RGBA16  = 10,   // 64-bit RGBA image        : 4 x 16-bit
    FIT_RGBF    = 11,   // 96-bit RGB float image   : 3 x 32-bit IEEE floating point
    FIT_RGBAF   = 12    // 128-bit RGBA float image : 4 x 32-bit IEEE floating point
}

/** Image color type used in FreeImage.
*/
alias int FREE_IMAGE_COLOR_TYPE;
enum : FREE_IMAGE_COLOR_TYPE
{
    FIC_MINISWHITE = 0,     // min value is white
    FIC_MINISBLACK = 1,     // min value is black
    FIC_RGB        = 2,     // RGB color model
    FIC_PALETTE    = 3,     // color map indexed
    FIC_RGBALPHA   = 4,     // RGB color model with alpha channel
    FIC_CMYK       = 5      // CMYK color model
}

/** Color quantization algorithms.
Constants used in FreeImage_ColorQuantize.
*/
alias int FREE_IMAGE_QUANTIZE;
enum : FREE_IMAGE_QUANTIZE
{
    FIQ_WUQUANT = 0,        // Xiaolin Wu color quantization algorithm
    FIQ_NNQUANT = 1         // NeuQuant neural-net quantization algorithm by Anthony Dekker
}

/** Dithering algorithms.
Constants used in FreeImage_Dither.
*/
alias int FREE_IMAGE_DITHER;
enum : FREE_IMAGE_DITHER
{
    FID_FS          = 0,    // Floyd & Steinberg error diffusion
    FID_BAYER4x4    = 1,    // Bayer ordered dispersed dot dithering (order 2 dithering matrix)
    FID_BAYER8x8    = 2,    // Bayer ordered dispersed dot dithering (order 3 dithering matrix)
    FID_CLUSTER6x6  = 3,    // Ordered clustered dot dithering (order 3 - 6x6 matrix)
    FID_CLUSTER8x8  = 4,    // Ordered clustered dot dithering (order 4 - 8x8 matrix)
    FID_CLUSTER16x16= 5,    // Ordered clustered dot dithering (order 8 - 16x16 matrix)
    FID_BAYER16x16  = 6     // Bayer ordered dispersed dot dithering (order 4 dithering matrix)
}

/** Lossless JPEG transformations
Constants used in FreeImage_JPEGTransform
*/
alias int FREE_IMAGE_JPEG_OPERATION;
enum : FREE_IMAGE_JPEG_OPERATION
{
    FIJPEG_OP_NONE          = 0,    // no transformation
    FIJPEG_OP_FLIP_H        = 1,    // horizontal flip
    FIJPEG_OP_FLIP_V        = 2,    // vertical flip
    FIJPEG_OP_TRANSPOSE     = 3,    // transpose across UL-to-LR axis
    FIJPEG_OP_TRANSVERSE    = 4,    // transpose across UR-to-LL axis
    FIJPEG_OP_ROTATE_90     = 5,    // 90-degree clockwise rotation
    FIJPEG_OP_ROTATE_180    = 6,    // 180-degree rotation
    FIJPEG_OP_ROTATE_270    = 7     // 270-degree clockwise (or 90 ccw)
}

/** Tone mapping operators.
Constants used in FreeImage_ToneMapping.
*/
alias int FREE_IMAGE_TMO;
enum : FREE_IMAGE_TMO
{
    FITMO_DRAGO03    = 0,   // Adaptive logarithmic mapping (F. Drago, 2003)
    FITMO_REINHARD05 = 1,   // Dynamic range reduction inspired by photoreceptor physiology (E. Reinhard, 2005)
    FITMO_FATTAL02   = 2    // Gradient domain high dynamic range compression (R. Fattal, 2002)
}

/** Upsampling / downsampling filters.
Constants used in FreeImage_Rescale.
*/
alias int FREE_IMAGE_FILTER;
enum : FREE_IMAGE_FILTER
{
    FILTER_BOX        = 0,  // Box, pulse, Fourier window, 1st order (constant) b-spline
    FILTER_BICUBIC    = 1,  // Mitchell & Netravali's two-param cubic filter
    FILTER_BILINEAR   = 2,  // Bilinear filter
    FILTER_BSPLINE    = 3,  // 4th order (cubic) b-spline
    FILTER_CATMULLROM = 4,  // Catmull-Rom spline, Overhauser spline
    FILTER_LANCZOS3   = 5   // Lanczos3 filter
}

/** Color channels.
Constants used in color manipulation routines.
*/
alias int FREE_IMAGE_COLOR_CHANNEL;
enum : FREE_IMAGE_COLOR_CHANNEL
{
    FICC_RGB    = 0,    // Use red, green and blue channels
    FICC_RED    = 1,    // Use red channel
    FICC_GREEN  = 2,    // Use green channel
    FICC_BLUE   = 3,    // Use blue channel
    FICC_ALPHA  = 4,    // Use alpha channel
    FICC_BLACK  = 5,    // Use black channel
    FICC_REAL   = 6,    // Complex images: use real part
    FICC_IMAG   = 7,    // Complex images: use imaginary part
    FICC_MAG    = 8,    // Complex images: use magnitude
    FICC_PHASE  = 9     // Complex images: use phase
}

// Metadata support ---------------------------------------------------------

/**
  Tag data type information (based on TIFF specifications)

  Note: RATIONALs are the ratio of two 32-bit integer values.
*/
alias int FREE_IMAGE_MDTYPE;
enum : FREE_IMAGE_MDTYPE
{
    FIDT_NOTYPE     = 0,    // placeholder
    FIDT_BYTE       = 1,    // 8-bit unsigned integer
    FIDT_ASCII      = 2,    // 8-bit bytes w/ last byte null
    FIDT_SHORT      = 3,    // 16-bit unsigned integer
    FIDT_LONG       = 4,    // 32-bit unsigned integer
    FIDT_RATIONAL   = 5,    // 64-bit unsigned fraction
    FIDT_SBYTE      = 6,    // 8-bit signed integer
    FIDT_UNDEFINED  = 7,    // 8-bit untyped data
    FIDT_SSHORT     = 8,    // 16-bit signed integer
    FIDT_SLONG      = 9,    // 32-bit signed integer
    FIDT_SRATIONAL  = 10,   // 64-bit signed fraction
    FIDT_FLOAT      = 11,   // 32-bit IEEE floating point
    FIDT_DOUBLE     = 12,   // 64-bit IEEE floating point
    FIDT_IFD        = 13,   // 32-bit unsigned integer (offset)
    FIDT_PALETTE    = 14,   // 32-bit RGBQUAD
    FIDT_LONG8      = 16,   // 64-bit unsigned integer
    FIDT_SLONG8     = 17,   // 64-bit signed integer
    FIDT_IFD8       = 18    // 64-bit unsigned integer (offset)
}

/**
  Metadata models supported by FreeImage
*/
alias int FREE_IMAGE_MDMODEL;
enum : FREE_IMAGE_MDMODEL
{
    FIMD_NODATA         = -1,
    FIMD_COMMENTS       = 0,    // single comment or keywords
    FIMD_EXIF_MAIN      = 1,    // Exif-TIFF metadata
    FIMD_EXIF_EXIF      = 2,    // Exif-specific metadata
    FIMD_EXIF_GPS       = 3,    // Exif GPS metadata
    FIMD_EXIF_MAKERNOTE = 4,    // Exif maker note metadata
    FIMD_EXIF_INTEROP   = 5,    // Exif interoperability metadata
    FIMD_IPTC           = 6,    // IPTC/NAA metadata
    FIMD_XMP            = 7,    // Abobe XMP metadata
    FIMD_GEOTIFF        = 8,    // GeoTIFF metadata
    FIMD_ANIMATION      = 9,    // Animation metadata
    FIMD_CUSTOM         = 10,   // Used to attach other metadata types to a dib
    FIMD_EXIF_RAW       = 11    // Exif metadata as a raw buffer
}

// File IO routines ---------------------------------------------------------

alias void* fi_handle;
extern(System)
{
	alias nothrow uint function(void *buffer, uint size, uint count, fi_handle handle) FI_ReadProc;
	alias nothrow uint function(void *buffer, uint size, uint count, fi_handle handle) FI_WriteProc;
	alias nothrow int function(fi_handle handle, c_long offset, int origin) FI_SeekProc;
	alias nothrow c_long function(fi_handle handle) FI_TellProc;
}

align(1) struct FreeImageIO
{
    FI_ReadProc  read_proc;     // pointer to the function used to read data
    FI_WriteProc write_proc;    // pointer to the function used to write data
    FI_SeekProc  seek_proc;     // pointer to the function used to seek
    FI_TellProc  tell_proc;     // pointer to the function used to aquire the current position
}

/**
Handle to a memory I/O stream
*/
struct FIMEMORY
{
    void *data;
}


// Plugin routines ----------------------------------------------------------

alias extern(C) const(char)* function() FI_FormatProc;
alias extern(C) const(char)* function() FI_DescriptionProc;
alias extern(C) const(char)* function() FI_ExtensionListProc;
alias extern(C) const(char)* function() FI_RegExprProc;
alias extern(C) void* function(FreeImageIO *io, fi_handle handle, BOOL read) FI_OpenProc;
alias extern(C) void function(FreeImageIO *io, fi_handle handle, void *data) FI_CloseProc;
alias extern(C) int function(FreeImageIO *io, fi_handle handle, void *data) FI_PageCountProc;
alias extern(C) int function(FreeImageIO *io, fi_handle handle, void *data) FI_PageCapabilityProc;
alias extern(C) FIBITMAP* function(FreeImageIO *io, fi_handle handle, int page, int flags, void *data) FI_LoadProc;
alias extern(C) BOOL function(FreeImageIO *io, FIBITMAP *dib, fi_handle handle, int page, int flags, void *data) FI_SaveProc;
alias extern(C) BOOL function(FreeImageIO *io, fi_handle handle) FI_ValidateProc;
alias extern(C) const(char) function() FI_MimeProc;
alias extern(C) BOOL function(int bpp) FI_SupportsExportBPPProc;
alias extern(C) BOOL function(FREE_IMAGE_TYPE type) FI_SupportsExportTypeProc;
alias extern(C) BOOL function() FI_SupportsICCProfilesProc;
alias extern(C) BOOL function() FI_SupportsNoPixelsProc;

struct Plugin
{
    FI_FormatProc format_proc;
    FI_DescriptionProc description_proc;
    FI_ExtensionListProc extension_proc;
    FI_RegExprProc regexpr_proc;
    FI_OpenProc open_proc;
    FI_CloseProc close_proc;
    FI_PageCountProc pagecount_proc;
    FI_PageCapabilityProc pagecapability_proc;
    FI_LoadProc load_proc;
    FI_SaveProc save_proc;
    FI_ValidateProc validate_proc;
    FI_MimeProc mime_proc;
    FI_SupportsExportBPPProc supports_export_bpp_proc;
    FI_SupportsExportTypeProc supports_export_type_proc;
    FI_SupportsICCProfilesProc supports_icc_profiles_proc;
    FI_SupportsNoPixelsProc supports_no_pixels_proc;
}


alias extern(C) void function(Plugin *plugin, int format_id) FI_InitProc;


// Load / Save flag constants -----------------------------------------------

enum
     FIF_LOAD_NOPIXELS   = 0x8000,   // loading: load the image header only (not supported by all plugins)
     BMP_DEFAULT         = 0,
     BMP_SAVE_RLE        = 1,
     CUT_DEFAULT         = 0,
     DDS_DEFAULT         = 0,
     EXR_DEFAULT         = 0,        // save data as half with piz-based wavelet compression
     EXR_FLOAT           = 0x0001,   // save data as float instead of as half (not recommended)
     EXR_NONE            = 0x0002,   // save with no compression
     EXR_ZIP             = 0x0004,   // save with zlib compression, in blocks of 16 scan lines
     EXR_PIZ             = 0x0008,   // save with piz-based wavelet compression
     EXR_PXR24           = 0x0010,   // save with lossy 24-bit float compression
     EXR_B44             = 0x0020,   // save with lossy 44% float compression - goes to 22% when combined with EXR_LC
     EXR_LC              = 0x0040,   // save images with one luminance and two chroma channels, rather than as RGB (lossy compression)
     FAXG3_DEFAULT       = 0,
     GIF_DEFAULT         = 0,
     GIF_LOAD256         = 1,        // Load the image as a 256 color image with ununsed palette entries, if it's 16 or 2 color
     GIF_PLAYBACK        = 2,        // 'Play' the GIF to generate each frame (as 32bpp) instead of returning raw frame data when loading
     HDR_DEFAULT         = 0,
     ICO_DEFAULT         = 0,
     ICO_MAKEALPHA       = 1,        // convert to 32bpp and create an alpha channel from the AND-mask when loading
     IFF_DEFAULT         = 0,
     J2K_DEFAULT         = 0,        // save with a 16:1 rate
     JP2_DEFAULT         = 0,        // save with a 16:1 rate
     JPEG_DEFAULT        = 0,        // loading (see JPEG_FAST); saving (see JPEG_QUALITYGOOD|JPEG_SUBSAMPLING_420)
     JPEG_FAST           = 0x0001,   // load the file as fast as possible, sacrificing some quality
     JPEG_ACCURATE       = 0x0002,   // load the file with the best quality, sacrificing some speed
     JPEG_CMYK           = 0x0004,   // load separated CMYK "as is" (use | to combine with other load flags)
     JPEG_EXIFROTATE     = 0x0008,   // load and rotate according to Exif 'Orientation' tag if available
     JPEG_QUALITYSUPERB  = 0x80,     // save with superb quality (100:1)
     JPEG_QUALITYGOOD    = 0x0100,   // save with good quality (75:1)
     JPEG_QUALITYNORMAL  = 0x0200,   // save with normal quality (50:1)
     JPEG_QUALITYAVERAGE = 0x0400,   // save with average quality (25:1)
     JPEG_QUALITYBAD     = 0x0800,   // save with bad quality (10:1)
     JPEG_PROGRESSIVE    = 0x2000,   // save as a progressive-JPEG (use | to combine with other save flags)

     JPEG_SUBSAMPLING_411 = 0x1000,  // save with high 4x1 chroma subsampling (4:1:1)
     JPEG_SUBSAMPLING_420 = 0x4000,  // save with medium 2x2 medium chroma subsampling (4:2:0) - default value
     JPEG_SUBSAMPLING_422 = 0x8000,  // save with low 2x1 chroma subsampling (4:2:2)
     JPEG_SUBSAMPLING_444 = 0x10000, // save with no chroma subsampling (4:4:4)
     JPEG_OPTIMIZE        = 0x20000, // on saving, compute optimal Huffman coding tables (can reduce a few percent of file size)
     JPEG_BASELINE       = 0x40000,  // save basic JPEG, without metadata or any markers
     KOALA_DEFAULT       = 0,
     LBM_DEFAULT         = 0,
     MNG_DEFAULT         = 0,
     PCD_DEFAULT         = 0,
     PCD_BASE            = 1,        // load the bitmap sized 768 x 512
     PCD_BASEDIV4        = 2,        // load the bitmap sized 384 x 256
     PCD_BASEDIV16       = 3,        // load the bitmap sized 192 x 128
     PCX_DEFAULT         = 0,
     PFM_DEFAULT         = 0,
     PICT_DEFAULT        = 0,
     PNG_DEFAULT         = 0,
     PNG_IGNOREGAMMA     = 1,        // loading: avoid gamma correction
     PNG_Z_BEST_SPEED    = 0x0001,   // save using ZLib level 1 compression flag (default value is 6)
     PNG_Z_DEFAULT_COMPRESSION = 0x0006,  // save using ZLib level 6 compression flag (default recommended value)
     PNG_Z_BEST_COMPRESSION    = 0x0009,  // save using ZLib level 9 compression flag (default value is 6)
     PNG_Z_NO_COMPRESSION      = 0x0100,  // save without ZLib compression
     PNG_INTERLACED            = 0x0200,  // save using Adam7 interlacing (use | to combine with other save flags)
     PNM_DEFAULT         = 0,
     PNM_SAVE_RAW        = 0,        // If set the writer saves in RAW format (i.e. P4, P5 or P6)
     PNM_SAVE_ASCII      = 1,        // If set the writer saves in ASCII format (i.e. P1, P2 or P3)
     PSD_DEFAULT         = 0,
     PSD_CMYK            = 1,        // reads tags for separated CMYK (default is conversion to RGB)
     PSD_LAB             = 2,        // reads tags for CIELab (default is conversion to RGB)
     RAS_DEFAULT         = 0,
     RAW_DEFAULT         = 0,        // load the file as linear RGB 48-bit
     RAW_PREVIEW         = 1,        // try to load the embedded JPEG preview with included Exif Data or default to RGB 24-bit
     RAW_DISPLAY         = 2,        // load the file as RGB 24-bit
     RAW_HALFSIZE        = 4,        // output a half-size color image
     SGI_DEFAULT         = 0,
     TARGA_DEFAULT       = 0,
     TARGA_LOAD_RGB888   = 1,        // If set the loader converts RGB555 and ARGB8888 -> RGB888.
     TARGA_SAVE_RLE      = 2,        // If set, the writer saves with RLE compression
     TIFF_DEFAULT        = 0,
     TIFF_CMYK           = 0x0001,   // reads/stores tags for separated CMYK (use | to combine with compression flags)
     TIFF_PACKBITS       = 0x0100,   // save using PACKBITS compression
     TIFF_DEFLATE        = 0x0200,   // save using DEFLATE compression (a.k.a. ZLIB compression)
     TIFF_ADOBE_DEFLATE  = 0x0400,   // save using ADOBE DEFLATE compression
     TIFF_NONE           = 0x0800,   // save without any compression
     TIFF_CCITTFAX3      = 0x1000,   // save using CCITT Group 3 fax encoding
     TIFF_CCITTFAX4      = 0x2000,   // save using CCITT Group 4 fax encoding
     TIFF_LZW            = 0x4000,   // save using LZW compression
     TIFF_JPEG           = 0x8000,   // save using JPEG compression
     TIFF_LOGLUV         = 0x10000,  // save using LogLuv compression
     WBMP_DEFAULT        = 0,
     XBM_DEFAULT         = 0,
     XPM_DEFAULT         = 0;

// Background filling options ---------------------------------------------------------
// Constants used in FreeImage_FillBackground and FreeImage_EnlargeCanvas

enum FI_COLOR_IS_RGB_COLOR        = 0x00,  // RGBQUAD color is a RGB color (contains no valid alpha channel)
     FI_COLOR_IS_RGBA_COLOR       = 0x01,  // RGBQUAD color is a RGBA color (contains a valid alpha channel)
     FI_COLOR_FIND_EQUAL_COLOR    = 0x02,  // For palettized images: lookup equal RGB color from palette
     FI_COLOR_ALPHA_IS_INDEX      = 0x04,  // The color's rgbReserved member (alpha) contains the palette index to be used
     FI_COLOR_PALETTE_SEARCH_MASK = (FI_COLOR_FIND_EQUAL_COLOR | FI_COLOR_ALPHA_IS_INDEX);  // No color lookup is performed


alias extern(C) nothrow void function(FREE_IMAGE_FORMAT fif, const(char)* msg) FreeImage_OutputMessageFunction;
alias extern(Windows) nothrow void function(FREE_IMAGE_FORMAT fif, const(char)* msg) FreeImage_OutputMessageFunctionStdCall;
