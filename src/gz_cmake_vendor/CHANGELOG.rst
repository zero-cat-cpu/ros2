^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package gz_cmake_vendor
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

0.5.1 (2026-06-10)
------------------
* Bump version to 5.1.1 (`#25 <https://github.com/gazebo-release/gz_cmake_vendor/issues/25>`_)
* Contributors: Steve Peters

0.5.0 (2026-05-14)
------------------

0.4.4 (2026-04-22)
------------------
* Bump version to 5.1.0 (`#24 <https://github.com/gazebo-release/gz_cmake_vendor/issues/24>`_)
* Contributors: Addisu Z. Taddese

0.4.3 (2026-02-13)
------------------
* Merge pull request `#23 <https://github.com/gazebo-release/gz_cmake_vendor/issues/23>`_
  Bump version to 5.0.2  ---------
* Contributors: Addisu Z. Taddese, Jose Luis Rivero, Steve Peters

0.4.2 (2026-01-30)
------------------
* Bump version to 5.0.1 (`#20 <https://github.com/gazebo-release/gz_cmake_vendor/issues/20>`_)
* Contributors: Addisu Z. Taddese

0.4.1 (2025-09-29)
------------------
* Bump version to 5.0.0 (`#19 <https://github.com/gazebo-release/gz_cmake_vendor/issues/19>`_)
* Contributors: Addisu Z. Taddese

0.4.0 (2025-09-08)
------------------
* Jetty support: bump to 5.0.0, fix package names (`#16 <https://github.com/gazebo-release/gz_cmake_vendor/issues/16>`_)
  * Jetty support: bump to 5.0.0, fix package names
  Major version numbers have been removed from package
  names in Gazebo Jetty, so extra cmake config files are
  no longer needed.
  * Add option VENDOR_FROM_LIB_VCS_REF
  This allows vendoring from a specified vcs ref instead
  of the hard-coded tag. When this option is set to true,
  a branch, tag, or commit can be specified in the
  LIB_VCS_REF variable. If LIB_VCS_REF is unspecified,
  vendoring will use main.
  * remove unused cmake config template
  * use lowercase to fix linter complaint
  * 5.0.0~pre1
  ---------
* Contributors: Steve Peters

0.3.1 (2025-05-22)
------------------
* Bump version to 4.2.0 (`#15 <https://github.com/gazebo-release/gz_cmake_vendor/issues/15>`_)
* Contributors: Jose Luis Rivero, Steve Peters

0.3.0 (2025-04-28)
------------------

0.2.2 (2025-02-26)
------------------
* Bump version to 4.1.1 (`#13 <https://github.com/gazebo-release/gz_cmake_vendor/issues/13>`_)
* Contributors: Steve Peters

0.2.1 (2024-11-12)
------------------
* Bump version to 4.1.0 (`#11 <https://github.com/gazebo-release/gz_cmake_vendor/issues/11>`_)
* Contributors: Steve Peters

0.2.0 (2024-09-26)
------------------
* Bump version to 4.0.0 (`#10 <https://github.com/gazebo-release/gz_cmake_vendor/issues/10>`_)
* Fixes the cmake-config used during find_package (`#8 <https://github.com/gazebo-release/gz_cmake_vendor/issues/8>`_)
  The provided cmake-config was not actually working if one did
  ```
  find_package(gz_cmake_vendor)
  find_package(gz-cmake)
  ```
  This because the config file tried to create aliases to targets
  that don't exist. For example, gz-cmake4::gz-cmake4 is not exported
  by gz-cmake.
* Remove the BUILD_DOCS cmake argument. (`#9 <https://github.com/gazebo-release/gz_cmake_vendor/issues/9>`_)
  It is apparently deprecated in newer Gazebo.
* Apply prerelease suffix and remove patch (`#7 <https://github.com/gazebo-release/gz_cmake_vendor/issues/7>`_)
* Upgrade to Ionic
* Contributors: Addisu Z. Taddese, Chris Lalancette

0.1.1 (2024-05-03)
------------------
* Update vendored version to 3.5.3
* Contributors: Addisu Z. Taddese

0.1.0 (2024-04-23)
------------------
* Use an alias target for root library
* Contributors: Addisu Z. Taddese

0.0.6 (2024-04-10)
------------------
* Add support for the `<pkg>::<pkg>` and `<pkg>::all` targets, fix sourcing of dsv files
* Contributors: Addisu Z. Taddese

0.0.5 (2024-04-08)
------------------
* Update vendored version to 3.5.2
* Contributors: Addisu Z. Taddese

0.0.4 (2024-03-29)
------------------
* Update vendored package version
* Contributors: Addisu Z. Taddese

0.0.3 (2024-03-28)
------------------
* Patch the pkg-config directory in the gz-cmake code. (`#4 <https://github.com/gazebo-release/gz_cmake_vendor/issues/4>`_)
  * Patch the pkg-config directory in the gz-cmake code.
  When building on the ROS 2 buildfarm, we aren't setting
  some of the CMAKE_PREFIX variables.  This means that
  using CMAKE_INSTALL_FULL_LIBDIR actually creates a path
  like /opt/ros/rolling/... , which makes debuild upset.
  However, we actually need the FULL_LIBDIR in order to
  calculate the relative path between it and the INSTALL_PREFIX.
  Work around this by having two variables; the
  pkgconfig_install_dir (relative), used to install the files,
  and pkgconfig_abs_install_dir (absolute), used to calculate
  the relative path between them.
  This should fix the build on the buildfarm.  I'll note that
  we are doing it here and not in gz-cmake proper because of
  knock-on effects to downstream gazebo.  If this is successful
  we may end up merging it there, at which point we can drop
  this patch.
  * Update GzPackage as well.
  ---------
* Contributors: Chris Lalancette

0.0.2 (2024-03-27)
------------------
* Require calling find_package on the underlying package (`#3 <https://github.com/gazebo-release/gz_cmake_vendor/issues/3>`_)
  This also changes the version of the vendor package to 0.0.1
  and adds the version of the vendored package in the description
* Fix linter (`#2 <https://github.com/gazebo-release/gz_cmake_vendor/issues/2>`_)
* Use `<depend>` on upstream package so that dependency is exported
* Update maintainer
* Add package.xml and CMakeLists (`#1 <https://github.com/gazebo-release/gz_cmake_vendor/issues/1>`_)
* Initial import
* Contributors: Addisu Z. Taddese
