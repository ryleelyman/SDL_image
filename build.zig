const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "SDL2_image",
        .target = target,
        .optimize = optimize,
    });

    const zig_sdl = b.dependency("SDL", .{
        .target = target,
        .optimize = optimize,
    });
    lib.addIncludePath(.{ .cwd_relative = "lib/SDL/zig-out/include/SDL2" });
    lib.linkLibrary(zig_sdl.artifact("SDL2"));

    lib.addCSourceFiles(&src_files, &.{});
    lib.linkLibC();
    lib.installHeader("SDL_image.h", "SDL2_image/SDL_image.h");
    b.installArtifact(lib);
}

const src_files = .{
    "IMG.c",
    "IMG_ImageIO.m",
    "IMG_WIC.c",
    "IMG_avif.c",
    "IMG_bmp.c",
    "IMG_gif.c",
    "IMG_jpg.c",
    "IMG_jxl.c",
    "IMG_lbm.c",
    "IMG_pcx.c",
    "IMG_png.c",
    "IMG_pnm.c",
    "IMG_qoi.c",
    "IMG_stb.c",
    "IMG_svg.c",
    "IMG_tga.c",
    "IMG_tif.c",
    "IMG_webp.c",
    "IMG_xcf.c",
    "IMG_xpm.c",
    "IMG_xv.c",
};
