#include "nit.common.h"
#define COLOR_toolcontext__Message___location 0
#define COLOR_toolcontext__Message___text 1
#define COLOR_kernel__Comparable_VTOTHER 0
short int location__Location___61d_61d(val* self, val* p0);
short int location__Location___60d(val* self, val* p0);
short int toolcontext__Message___60d(val* self, val* p0);
val* string__NativeString__to_s_with_length(char* self, long p0);
val* NEW_array__Array(const struct type* type);
extern const struct type type_array__Arraykernel__Object;
val* NEW_array__NativeArray(int length, const struct type* type);
extern const struct type type_array__NativeArraykernel__Object;
#define COLOR_array__Array__with_native 65
#define COLOR_string__Object__to_s 7
val* toolcontext__Message__to_s(val* self);
val* BOX_kernel__Char(char);
#define COLOR_location__Location___file 0
val* location__Location__colored_line(val* self, val* p0);
val* toolcontext__Message__to_color_string(val* self);
#define COLOR_toolcontext__ToolContext___error_count 0
#define COLOR_toolcontext__ToolContext___warning_count 1
#define COLOR_toolcontext__ToolContext___log_directory 2
#define COLOR_toolcontext__ToolContext___messages 3
#define COLOR_toolcontext__ToolContext___message_sorter 4
long array__AbstractArrayRead__length(val* self);
extern const struct type type_kernel__Int;
void sorter__Comparator__sort(val* self, val* p0);
val* array__AbstractArrayRead__iterator(val* self);
short int array__ArrayIterator__is_ok(val* self);
val* array__ArrayIterator__item(val* self);
#define COLOR_toolcontext__ToolContext___opt_no_color 15
#define COLOR_opts__Option___value 6
#define COLOR_file__Sys___stderr 3
void file__OFStream__write(val* self, val* p0);
void array__ArrayIterator__next(val* self);
void array__AbstractArray__clear(val* self);
void toolcontext__ToolContext__check_errors(val* self);
val* NEW_toolcontext__Message(const struct type* type);
extern const struct type type_toolcontext__Message;
void array__Array__add(val* self, val* p0);
#define COLOR_toolcontext__ToolContext___opt_stop_on_first_error 14
void toolcontext__ToolContext__error(val* self, val* p0, val* p1);
void toolcontext__ToolContext__fatal_error(val* self, val* p0, val* p1);
#define COLOR_toolcontext__ToolContext___opt_warn 6
extern const struct class class_kernel__Int;
void toolcontext__ToolContext__warning(val* self, val* p0, val* p1);
#define COLOR_toolcontext__ToolContext___verbose_level 17
void file__Object__print(val* self, val* p0);
void toolcontext__ToolContext__info(val* self, val* p0, long p1);
#define COLOR_toolcontext__ToolContext___option_context 5
#define COLOR_toolcontext__ToolContext___opt_quiet 7
#define COLOR_toolcontext__ToolContext___opt_log 8
#define COLOR_toolcontext__ToolContext___opt_log_dir 9
#define COLOR_toolcontext__ToolContext___opt_help 10
#define COLOR_toolcontext__ToolContext___opt_version 11
#define COLOR_toolcontext__ToolContext___opt_set_dummy_tool 12
#define COLOR_toolcontext__ToolContext___opt_verbose 13
#define COLOR_toolcontext__ToolContext___opt_bash_completion 16
extern const struct type type_array__Arrayopts__Option;
extern const struct type type_array__NativeArrayopts__Option;
void opts__OptionContext__add_option(val* self, val* p0);
void toolcontext__ToolContext__init(val* self);
#define COLOR_toolcontext__ToolContext___tooldescription 18
#define COLOR_toolcontext__ToolContext___accept_no_arguments 19
void opts__OptionContext__usage(val* self);
void toolcontext__ToolContext__usage(val* self);
#define COLOR_opts__Option_VTVALUE 0
val* BOX_kernel__Int(long);
void opts__OptionContext__parse(val* self, val* p0);
val* toolcontext__ToolContext__version(val* self);
val* NEW_toolcontext__BashCompletion(const struct type* type);
extern const struct type type_toolcontext__BashCompletion;
void toolcontext__BashCompletion__init(val* self, val* p0);
#define COLOR_file__Sys___stdout 2
void template__Template__write_to(val* self, val* p0);
val* opts__OptionContext__get_errors(val* self);
short int array__AbstractArrayRead__is_empty(val* self);
#define COLOR_opts__OptionContext___rest 1
#define COLOR_kernel__Object___61d_61d 2
void file__String__mkdir(val* self);
val* toolcontext__ToolContext__compute_nit_dir(val* self);
#define COLOR_toolcontext__ToolContext___nit_dir 20
void toolcontext__ToolContext__process_options(val* self, val* p0);
val* version__Object__nit_version(val* self);
val* string__Sys__program_name(val* self);
val* file__String__basename(val* self, val* p0);
val* toolcontext__ToolContext__toolname(val* self);
val* environ__String__environ(val* self);
short int string__Text__is_empty(val* self);
val* file__String__dirname(val* self);
short int file__String__file_exists(val* self);
val* file__String__simplify_path(val* self);
val* file__String__realpath(val* self);
val* file__String__join_path(val* self, val* p0);
#define COLOR_toolcontext__BashCompletion___toolcontext 4
extern const struct type type_array__Arraystring__String;
void array__Array__init(val* self);
#define COLOR_opts__OptionContext___options 0
#define COLOR_opts__Option___names 0
short int string__Text__has_prefix(val* self, val* p0);
val* toolcontext__BashCompletion__extract_options_names(val* self);
void template__Template__addn(val* self, val* p0);
val* string__Collection__join(val* self, val* p0);
void toolcontext__BashCompletion__rendering(val* self);
