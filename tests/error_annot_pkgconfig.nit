# This file is part of NIT ( http://www.nitlanguage.org ).
#
# Copyright 2013 Alexis Laferrière <alexis.laf@xymus.net>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#alt0# module error_annot_pkgconfig_alt0 is pkgconfig # defaults to module name
#alt1# module error_annot_pkgconfig_alt1 is pkgconfig("missing-lib", "other missing lib")
#alt2# module error_annot_pkgconfig_alt2 is pkgconfig(1234) # not a string

fun foo `{ `}
foo
