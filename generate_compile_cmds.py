#!/usr/bin/env python3
import argparse
import os
import pathlib

COMPILE_COMMAND_JSON = "compile_commands.json"
CATKIN_WS_ENV_VARIABLE = "CATKIN_WS"
catkin_ws = os.getenv("CATKIN_WS")


def get_pkgs_in_workspace(workspace_path):
    # Search all catkin packages in the source folder.
    src_dir = os.path.join(workspace_path, "src")
    src_package_paths = {}
    for package_xml_path in pathlib.Path(src_dir).rglob("*package.xml"):
        package_path = os.path.dirname(str(package_xml_path))
        package_name = os.path.split(package_path)[-1]
        src_package_paths[package_name] = package_path

    return src_package_paths


def parse_args():
    """parse arguments"""
    parser = argparse.ArgumentParser(
        description="Add a symbolic link of the compile_command.json in the build"
        "folder into the package in src."
    )
    parser.add_argument(
        "--catkin_ws",
        type=str,
        help="Catkin workspace in which to create the compile commands links.",
        default=catkin_ws,
    )
    args = parser.parse_args()
    return args


if __name__ == "__main__":
    args = parse_args()

    # Get all packages cloned in src
    src_package_paths = get_pkgs_in_workspace(args.catkin_ws)

    # Get the catkin ws build directory
    build_dir = os.path.join(args.catkin_ws, "build")

    print(
        f"Linking in the src space the {COMPILE_COMMAND_JSON} inside {args.catkin_ws}/build."
    )
    for pkg, pkg_source_path in src_package_paths.items():
        compile_cmd_files = os.path.realpath(
            os.path.join(build_dir, pkg, COMPILE_COMMAND_JSON)
        )
        if not os.path.isfile(compile_cmd_files):
            # No compile commands json found
            continue

        sym_link = os.path.join(pkg_source_path, COMPILE_COMMAND_JSON)
        print(f" - {sym_link} -> {compile_cmd_files}")

        # Check if file is already present and not modified
        if os.path.isfile(sym_link):
            if os.path.islink(sym_link) and compile_cmd_files == os.path.realpath(
                os.readlink(sym_link)
            ):
                # Sym link already there!
                continue
            else:  # it's a regular file or pointing to the wrong location
                os.remove(sym_link)

        os.symlink(compile_cmd_files, sym_link)
