unit hdf5dll;

// Delphi wrapper for HDF5 library.

// Auto-generated 2014-11-21 by hdf5pas.py.

interface

uses windows, system.sysUtils, vcl.forms, regutil;

type
  UInt64 = Int64;
  PUInt64 = ^Int64;
  PCardinal = ^Cardinal;
  PPointer = ^Pointer;
  PPAnsiChar = ^PAnsiChar;

type
  int32_t = Integer;
  Pint32_t = ^int32_t;
  uint32_t = Cardinal;
  Puint32_t = ^uint32_t;
  int64_t = Int64;
  Pint64_t = ^int64_t;
  uint64_t = UInt64;
  Puint64_t = ^uint64_t;
  time_t = Integer;
  Ptime_t = ^time_t;
  size_t = Cardinal;
  Psize_t = ^size_t;
  ssize_t = Integer;
  Pssize_t = ^ssize_t;
  off_t = Integer;
  Poff_t = ^off_t;
  PFILE = Pointer;

type
  hsize_t = UInt64;
  Phsize_t = ^hsize_t;
  hssize_t = Int64;
  Phssize_t = ^hssize_t;
  haddr_t = UInt64;
  Phaddr_t = ^haddr_t;
const
  HADDR_UNDEF = -1;

(* Version numbers *)
const
  H5_VERS_MAJOR = 1;  (* For major interface/format changes *)
  H5_VERS_MINOR = 8;  (* For minor interface/format changes *)
  H5_VERS_RELEASE = 14;  (* For tweaks, bug-fixes, or development *)
  H5_VERS_SUBRELEASE = '';  (* For pre-releases like snap0 *)
(* Empty string for real releases.           *)
  H5_VERS_INFO = 'HDF5 library version: 1.8.14';  (* Full version string *)

(*
 * Status return values.  Failed integer functions in HDF5 result almost
 * always in a negative value (unsigned failing functions sometimes return
 * zero for failure) while successfull return is non-negative (often zero).
 * The negative failure value is most commonly -1, but don't bet on it.  The
 * proper way to detect failure is something like:
 *
 *      if((dset = H5Dopen2(file, name)) < 0)
 *          fprintf(stderr, "unable to open the requested dataset\n");
 *)
type
  herr_t = Integer;
  Pherr_t = ^herr_t;
  H5_ih_info_t = record
            index_size: hsize_t;
            heap_size: hsize_t;
        end;
  Tsohm =record
        hdr_size: hsize_t;
        msgs_info: H5_ih_info_t;
        end;


(*
 * Boolean type.  Successful return values are zero (false) or positive
 * (true). The typical true value is 1 but don't bet on it.  Boolean
 * functions cannot fail.  Functions that return `htri_t' however return zero
 * (false), positive (true), or negative (failure). The proper way to test
 * for truth from a htri_t function is:
 *
 *      if ((retval = H5Tcommitted(type))>0) {
 *          printf("data type is committed\n");
 *      } else if (!retval) {
 *          printf("data type is not committed\n");
 *      } else {
 *          printf("error determining whether data type is committed\n");
 *      }
 *)
type
  hbool_t = Cardinal;
  Phbool_t = ^hbool_t;
  htri_t = Integer;
  Phtri_t = ^htri_t;

// File addresses have their own types.
const
  HADDR_MAX = HADDR_UNDEF-1;

// Common iteration orders
type
  H5_iter_order_t = Integer;
  PH5_iter_order_t = ^H5_iter_order_t;
const
  H5_ITER_UNKNOWN = -1;  (* Unknown order *)
  H5_ITER_INC = 0;  (* Increasing order *)
  H5_ITER_DEC = 1;  (* Decreasing order *)
  H5_ITER_NATIVE = 2;  (* No particular order, whatever is fastest *)
  H5_ITER_N = 3;  (* Number of iteration orders *)

// Iteration callback values
// (Actually, any positive value will cause the iterator to stop and pass back that positive value to the function that called the iterator)
const
  H5_ITER_ERROR = -1;
  H5_ITER_CONT = 0;
  H5_ITER_STOP = 1;

var
  H5T_STD_I32BE: Integer = -1;
  H5T_STD_I32LE: Integer = -1;
  H5T_NATIVE_INT: Integer = -1;
  H5T_C_S1: Integer = -1;
  H5T_NATIVE_FLOAT: Integer = -1;
  H5T_NATIVE_DOUBLE: Integer = -1;

  H5P_DATASET_CREATE: Integer = -1;
  H5P_DATASET_XFER: Integer = -1;

  H5T_NATIVE_UCHAR: Integer=-1;
  H5T_NATIVE_ULLONG: integer=-1;
  H5T_NATIVE_UINT: Integer=-1;
  H5T_NATIVE_USHORT: Integer=-1;
  H5T_NATIVE_SHORT: Integer=-1;

(*
 * The types of indices on links in groups/attributes on objects.
 * Primarily used for "<do> <foo> by index" routines and for iterating over
 * links in groups/attributes on objects.
 *)
type
  H5_index_t = Integer;
  PH5_index_t = ^H5_index_t;
const
  H5_INDEX_UNKNOWN = -1;  (* Unknown index type *)
  H5_INDEX_NAME = 0;  (* Index on names *)
  H5_INDEX_CRT_ORDER = 1;  (* Index on creation order *)
  H5_INDEX_N = 2;  (* Number of indices defined *)

(*
 * Storage info struct used by H5O_info_t and H5F_info_t
 *)
type
  PPH5_ih_info_t = ^PH5_ih_info_t;
  PH5_ih_info_t = Pointer;

(*
 * Library type values.  Start with `1' instead of `0' because it makes the
 * tracing output look better when hid_t values are large numbers.  Change the
 * TYPE_BITS in H5I.c if the MAXID gets larger than 32 (an assertion will
 * fail otherwise).
 *
 * When adding types here, add a section to the 'misc19' test in test/tmisc.c
 * to verify that the H5I{inc|dec|get}_ref() routines work correctly with in.
 *
 *)
type
  H5I_type_t = Integer;
  PH5I_type_t = ^H5I_type_t;
const
  H5I_UNINIT = -2;  (* uninitialized type *)
  H5I_BADID = -1;  (* invalid Type *)
  H5I_FILE = 1;  (* type ID for File objects *)
  H5I_GROUP = 2;  (* type ID for Group objects *)
  H5I_DATATYPE = 3;  (* type ID for Datatype objects *)
  H5I_DATASPACE = 4;  (* type ID for Dataspace objects *)
  H5I_DATASET = 5;  (* type ID for Dataset objects *)
  H5I_ATTR = 6;  (* type ID for Attribute objects *)
  H5I_REFERENCE = 7;  (* type ID for Reference objects *)
  H5I_VFL = 8;  (* type ID for virtual file layer *)
  H5I_GENPROP_CLS = 9;  (* type ID for generic property list classes *)
  H5I_GENPROP_LST = 10;  (* type ID for generic property lists *)
  H5I_ERROR_CLASS = 11;  (* type ID for error classes *)
  H5I_ERROR_MSG = 12;  (* type ID for error messages *)
  H5I_ERROR_STACK = 13;  (* type ID for error stacks *)
  H5I_NTYPES = 14;  (* number of library types, MUST BE LAST! *)

(* Type of atoms to return to users *)
type
  hid_t = Integer;
  Phid_t = ^hid_t;

(* An invalid object ID. This is also negative for error return. *)
const
  H5I_INVALID_HID = -1;

(*
 * Function for freeing objects. This function will be called with an object
 * ID type number and a pointer to the object. The function should free the
 * object and return non-negative to indicate that the object
 * can be removed from the ID type. If the function returns negative
 * (failure) then the object will remain in the ID type.
 *)
type
  H5I_free_t = function(p: Pointer): herr_t; cdecl;
  PH5I_free_t = ^H5I_free_t;

(* Type of the function to compare objects & keys *)
type
  H5I_search_func_t = function(obj: Pointer; id: hid_t; key: Pointer): Integer; cdecl;
  PH5I_search_func_t = ^H5I_search_func_t;
type
  H5C_cache_incr_mode = Integer;
  PH5C_cache_incr_mode = ^H5C_cache_incr_mode;
const
  H5C_incr__off = 0;
  H5C_incr__threshold = 1;
type
  H5C_cache_flash_incr_mode = Integer;
  PH5C_cache_flash_incr_mode = ^H5C_cache_flash_incr_mode;
const
  H5C_flash_incr__off = 0;
  H5C_flash_incr__add_space = 1;
type
  H5C_cache_decr_mode = Integer;
  PH5C_cache_decr_mode = ^H5C_cache_decr_mode;
const
  H5C_decr__off = 0;
  H5C_decr__threshold = 1;
  H5C_decr__age_out = 2;
  H5C_decr__age_out_with_threshold = 3;

(* These typedefs are currently used for VL datatype allocation/freeing *)
type
  H5MM_allocate_t = function(size: size_t; alloc_info: Pointer): Pointer; cdecl;
  PH5MM_allocate_t = ^H5MM_allocate_t;
  H5MM_free_t = procedure(mem: Pointer; free_info: Pointer); cdecl;
  PH5MM_free_t = ^H5MM_free_t;

(*
 * Filter identifiers.  Values 0 through 255 are for filters defined by the
 * HDF5 library.  Values 256 through 511 are available for testing new
 * filters. Subsequent values should be obtained from the HDF5 development
 * team at hdf5dev@ncsa.uiuc.edu.  These values will never change because they
 * appear in the HDF5 files.
 *)
type
  H5Z_filter_t = Integer;
  PH5Z_filter_t = ^H5Z_filter_t;

(* Filter IDs *)
const
  H5Z_FILTER_ERROR = -1;  (* no filter *)
  H5Z_FILTER_NONE = 0;  (* reserved indefinitely *)
  H5Z_FILTER_DEFLATE = 1;  (* deflation like gzip *)
  H5Z_FILTER_SHUFFLE = 2;  (* shuffle the data *)
  H5Z_FILTER_FLETCHER32 = 3;  (* fletcher32 checksum of EDC *)
  H5Z_FILTER_SZIP = 4;  (* szip compression *)
  H5Z_FILTER_NBIT = 5;  (* nbit compression *)
  H5Z_FILTER_SCALEOFFSET = 6;  (* scale+offset compression *)
  H5Z_FILTER_RESERVED = 256;  (* filter ids below this value are reserved for library use *)
const
  H5Z_FILTER_MAX = 65535;  (* maximum filter id *)

(* General macros *)
const
  H5Z_FILTER_ALL = 0;  (* Symbol to remove all filters in H5Premove_filter *)
  H5Z_MAX_NFILTERS = 32;  (* Maximum number of filters allowed in a pipeline *)
(* (should probably be allowed to be an
 * unlimited amount, but currently each
 * filter uses a bit in a 32-bit field,
 * so the format would have to be
 * changed to accomodate that)
 *)

(* Flags for filter definition (stored) *)
const
  H5Z_FLAG_DEFMASK = 255;  (* definition flag mask *)
  H5Z_FLAG_MANDATORY = 0;  (* filter is mandatory *)
  H5Z_FLAG_OPTIONAL = 1;  (* filter is optional *)

(* Additional flags for filter invocation (not stored) *)
const
  H5Z_FLAG_INVMASK = 65280;  (* invocation flag mask *)
  H5Z_FLAG_REVERSE = 256;  (* reverse direction; read *)
  H5Z_FLAG_SKIP_EDC = 512;  (* skip EDC filters for read *)

(* Special parameters for szip compression *)
(* [These are aliases for the similar definitions in szlib.h, which we can't
 * include directly due to the duplication of various symbols with the zlib.h
 * header file] *)
const
  H5_SZIP_ALLOW_K13_OPTION_MASK = 1;
  H5_SZIP_CHIP_OPTION_MASK = 2;
  H5_SZIP_EC_OPTION_MASK = 4;
  H5_SZIP_NN_OPTION_MASK = 32;
  H5_SZIP_MAX_PIXELS_PER_BLOCK = 32;

(* Macros for the shuffle filter *)
const
  H5Z_SHUFFLE_USER_NPARMS = 0;  (* Number of parameters that users can set *)
  H5Z_SHUFFLE_TOTAL_NPARMS = 1;  (* Total number of parameters for filter *)

(* Macros for the szip filter *)
const
  H5Z_SZIP_USER_NPARMS = 2;  (* Number of parameters that users can set *)
  H5Z_SZIP_TOTAL_NPARMS = 4;  (* Total number of parameters for filter *)
  H5Z_SZIP_PARM_MASK = 0;  (* "User" parameter for option mask *)
  H5Z_SZIP_PARM_PPB = 1;  (* "User" parameter for pixels-per-block *)
  H5Z_SZIP_PARM_BPP = 2;  (* "Local" parameter for bits-per-pixel *)
  H5Z_SZIP_PARM_PPS = 3;  (* "Local" parameter for pixels-per-scanline *)

(* Macros for the nbit filter *)
const
  H5Z_NBIT_USER_NPARMS = 0;  (* Number of parameters that users can set *)

(* Macros for the scale offset filter *)
const
  H5Z_SCALEOFFSET_USER_NPARMS = 2;  (* Number of parameters that users can set *)

(* Special parameters for ScaleOffset filter*)
const
  H5Z_SO_INT_MINBITS_DEFAULT = 0;
type
  H5Z_SO_scale_type_t = Integer;
  PH5Z_SO_scale_type_t = ^H5Z_SO_scale_type_t;
const
  H5Z_SO_FLOAT_DSCALE = 0;
  H5Z_SO_FLOAT_ESCALE = 1;
  H5Z_SO_INT = 2;

(* Current version of the H5Z_class_t struct *)
const
  H5Z_CLASS_T_VERS = 1;

(* Values to decide if EDC is enabled for reading data *)
type
  H5Z_EDC_t = Integer;
  PH5Z_EDC_t = ^H5Z_EDC_t;
const
  H5Z_ERROR_EDC = -1;  (* error value *)
  H5Z_DISABLE_EDC = 0;
  H5Z_ENABLE_EDC = 1;
  H5Z_NO_EDC = 2;  (* must be the last *)

(* Bit flags for H5Zget_filter_info *)
const
  H5Z_FILTER_CONFIG_ENCODE_ENABLED = 1;
  H5Z_FILTER_CONFIG_DECODE_ENABLED = 2;

(* Return values for filter callback function *)
type
  H5Z_cb_return_t = Integer;
  PH5Z_cb_return_t = ^H5Z_cb_return_t;
const
  H5Z_CB_ERROR = -1;
  H5Z_CB_FAIL = 0;  (* I/O should fail if filter fails. *)
  H5Z_CB_CONT = 1;  (* I/O continues if filter fails. *)
  H5Z_CB_NO = 2;

(* Filter callback function definition *)
type
  H5Z_filter_func_t = function(filter: H5Z_filter_t; buf: Pointer; buf_size: size_t; op_data: Pointer): H5Z_cb_return_t; cdecl;
  PH5Z_filter_func_t = ^H5Z_filter_func_t;

(* Structure for filter callback property *)
type
  PPH5Z_cb_t = ^PH5Z_cb_t;
  PH5Z_cb_t = Pointer;

(*
 * Before a dataset gets created, the "can_apply" callbacks for any filters used
 * in the dataset creation property list are called
 * with the dataset's dataset creation property list, the dataset's datatype and
 * a dataspace describing a chunk (for chunked dataset storage).
 *
 * The "can_apply" callback must determine if the combination of the dataset
 * creation property list setting, the datatype and the dataspace represent a
 * valid combination to apply this filter to.  For example, some cases of
 * invalid combinations may involve the filter not operating correctly on
 * certain datatypes (or certain datatype sizes), or certain sizes of the chunk
 * dataspace.
 *
 * The "can_apply" callback can be the NULL pointer, in which case, the library
 * will assume that it can apply to any combination of dataset creation
 * property list values, datatypes and dataspaces.
 *
 * The "can_apply" callback returns positive a valid combination, zero for an
 * invalid combination and negative for an error.
 *)
type
  H5Z_can_apply_func_t = function(dcpl_id: hid_t; type_id: hid_t; space_id: hid_t): htri_t; cdecl;
  PH5Z_can_apply_func_t = ^H5Z_can_apply_func_t;

(*
 * After the "can_apply" callbacks are checked for new datasets, the "set_local"
 * callbacks for any filters used in the dataset creation property list are
 * called.  These callbacks receive the dataset's private copy of the dataset
 * creation property list passed in to H5Dcreate (i.e. not the actual property
 * list passed in to H5Dcreate) and the datatype ID passed in to H5Dcreate
 * (which is not copied and should not be modified) and a dataspace describing
 * the chunk (for chunked dataset storage) (which should also not be modified).
 *
 * The "set_local" callback must set any parameters that are specific to this
 * dataset, based on the combination of the dataset creation property list
 * values, the datatype and the dataspace.  For example, some filters perform
 * different actions based on different datatypes (or datatype sizes) or
 * different number of dimensions or dataspace sizes.
 *
 * The "set_local" callback can be the NULL pointer, in which case, the library
 * will assume that there are no dataset-specific settings for this filter.
 *
 * The "set_local" callback must return non-negative on success and negative
 * for an error.
 *)
type
  H5Z_set_local_func_t = function(dcpl_id: hid_t; type_id: hid_t; space_id: hid_t): herr_t; cdecl;
  PH5Z_set_local_func_t = ^H5Z_set_local_func_t;

(*
 * A filter gets definition flags and invocation flags (defined above), the
 * client data array and size defined when the filter was added to the
 * pipeline, the size in bytes of the data on which to operate, and pointers
 * to a buffer and its allocated size.
 *
 * The filter should store the result in the supplied buffer if possible,
 * otherwise it can allocate a new buffer, freeing the original.  The
 * allocated size of the new buffer should be returned through the BUF_SIZE
 * pointer and the new buffer through the BUF pointer.
 *
 * The return value from the filter is the number of bytes in the output
 * buffer. If an error occurs then the function should return zero and leave
 * all pointer arguments unchanged.
 *)
type
  H5Z_func_t = function(flags: Cardinal; cd_nelmts: size_t; cd_values: PCardinal; nbytes: size_t; buf_size: Psize_t; buf: PPointer): size_t; cdecl;
  PH5Z_func_t = ^H5Z_func_t;

(*
 * The filter table maps filter identification numbers to structs that
 * contain a pointers to the filter function and timing statistics.
 *)
type
  PPH5Z_class2_t = ^PH5Z_class2_t;
  PH5Z_class2_t = Pointer;

(* These are the various classes of datatypes *)
(* If this goes over 16 types (0-15), the file format will need to change) *)
type
  H5T_class_t = Integer;
  PH5T_class_t = ^H5T_class_t;
const
  H5T_NO_CLASS = -1;  (* error *)
  H5T_INTEGER = 0;  (* integer types *)
  H5T_FLOAT = 1;  (* floating-point types *)
  H5T_TIME = 2;  (* date and time types *)
  H5T_STRING = 3;  (* character string types *)
  H5T_BITFIELD = 4;  (* bit field types *)
  H5T_OPAQUE = 5;  (* opaque types *)
  H5T_COMPOUND = 6;  (* compound types *)
  H5T_REFERENCE = 7;  (* reference types *)
  H5T_ENUM = 8;  (* enumeration types *)
  H5T_VLEN = 9;  (* Variable-Length types *)
  H5T_ARRAY = 10;  (* Array types *)

  H5T_NCLASSES = 11;  (* this must be last *)

(* Byte orders *)
type
  H5T_order_t = Integer;
  PH5T_order_t = ^H5T_order_t;
const
  H5T_ORDER_ERROR = -1;  (* error *)
  H5T_ORDER_LE = 0;  (* little endian *)
  H5T_ORDER_BE = 1;  (* bit endian *)
  H5T_ORDER_VAX = 2;  (* VAX mixed endian *)
  H5T_ORDER_MIXED = 3;  (* Compound type with mixed member orders *)
  H5T_ORDER_NONE = 4;  (* no particular order (strings, bits,..) *)
(*H5T_ORDER_NONE must be last *)

(* Types of integer sign schemes *)
type
  H5T_sign_t = Integer;
  PH5T_sign_t = ^H5T_sign_t;
const
  H5T_SGN_ERROR = -1;  (* error *)
  H5T_SGN_NONE = 0;  (* this is an unsigned type *)
  H5T_SGN_2 = 1;  (* two's complement *)

  H5T_NSGN = 2;  (* this must be last! *)

(* Floating-point normalization schemes *)
type
  H5T_norm_t = Integer;
  PH5T_norm_t = ^H5T_norm_t;
const
  H5T_NORM_ERROR = -1;  (* error *)
  H5T_NORM_IMPLIED = 0;  (* msb of mantissa isn't stored, always 1 *)
  H5T_NORM_MSBSET = 1;  (* msb of mantissa is always 1 *)
  H5T_NORM_NONE = 2;  (* not normalized *)
(*H5T_NORM_NONE must be last *)

(*
 * Character set to use for text strings.  Do not change these values since
 * they appear in HDF5 files!
 *)
type
  H5T_cset_t = Integer;
  PH5T_cset_t = ^H5T_cset_t;
const
  H5T_CSET_ERROR = -1;  (* error *)
  H5T_CSET_ASCII = 0;  (* US ASCII *)
  H5T_CSET_UTF8 = 1;  (* UTF-8 Unicode encoding *)
  H5T_CSET_RESERVED_2 = 2;  (* reserved for later use *)
  H5T_CSET_RESERVED_3 = 3;  (* reserved for later use *)
  H5T_CSET_RESERVED_4 = 4;  (* reserved for later use *)
  H5T_CSET_RESERVED_5 = 5;  (* reserved for later use *)
  H5T_CSET_RESERVED_6 = 6;  (* reserved for later use *)
  H5T_CSET_RESERVED_7 = 7;  (* reserved for later use *)
  H5T_CSET_RESERVED_8 = 8;  (* reserved for later use *)
  H5T_CSET_RESERVED_9 = 9;  (* reserved for later use *)
  H5T_CSET_RESERVED_10 = 10;  (* reserved for later use *)
  H5T_CSET_RESERVED_11 = 11;  (* reserved for later use *)
  H5T_CSET_RESERVED_12 = 12;  (* reserved for later use *)
  H5T_CSET_RESERVED_13 = 13;  (* reserved for later use *)
  H5T_CSET_RESERVED_14 = 14;  (* reserved for later use *)
  H5T_CSET_RESERVED_15 = 15;  (* reserved for later use *)
const
  H5T_NCSET = H5T_CSET_RESERVED_2;  (* Number of character sets actually defined *)

(*
 * Type of padding to use in character strings.  Do not change these values
 * since they appear in HDF5 files!
 *)
type
  H5T_str_t = Integer;
  PH5T_str_t = ^H5T_str_t;
const
  H5T_STR_ERROR = -1;  (* error *)
  H5T_STR_NULLTERM = 0;  (* null terminate like in C *)
  H5T_STR_NULLPAD = 1;  (* pad with nulls *)
  H5T_STR_SPACEPAD = 2;  (* pad with spaces like in Fortran *)
  H5T_STR_RESERVED_3 = 3;  (* reserved for later use *)
  H5T_STR_RESERVED_4 = 4;  (* reserved for later use *)
  H5T_STR_RESERVED_5 = 5;  (* reserved for later use *)
  H5T_STR_RESERVED_6 = 6;  (* reserved for later use *)
  H5T_STR_RESERVED_7 = 7;  (* reserved for later use *)
  H5T_STR_RESERVED_8 = 8;  (* reserved for later use *)
  H5T_STR_RESERVED_9 = 9;  (* reserved for later use *)
  H5T_STR_RESERVED_10 = 10;  (* reserved for later use *)
  H5T_STR_RESERVED_11 = 11;  (* reserved for later use *)
  H5T_STR_RESERVED_12 = 12;  (* reserved for later use *)
  H5T_STR_RESERVED_13 = 13;  (* reserved for later use *)
  H5T_STR_RESERVED_14 = 14;  (* reserved for later use *)
  H5T_STR_RESERVED_15 = 15;  (* reserved for later use *)
const
  H5T_NSTR = H5T_STR_RESERVED_3;  (* num H5T_str_t types actually defined *)

(* Type of padding to use in other atomic types *)
type
  H5T_pad_t = Integer;
  PH5T_pad_t = ^H5T_pad_t;
const
  H5T_PAD_ERROR = -1;  (* error *)
  H5T_PAD_ZERO = 0;  (* always set to zero *)
  H5T_PAD_ONE = 1;  (* always set to one *)
  H5T_PAD_BACKGROUND = 2;  (* set to background value *)

  H5T_NPAD = 3;  (* THIS MUST BE LAST *)

(* Commands sent to conversion functions *)
type
  H5T_cmd_t = Integer;
  PH5T_cmd_t = ^H5T_cmd_t;
const
  H5T_CONV_INIT = 0;  (* query and/or initialize private data *)
  H5T_CONV_CONV = 1;  (* convert data from source to dest datatype *)
  H5T_CONV_FREE = 2;  (* function is being removed from path *)

(* How is the `bkg' buffer used by the conversion function? *)
type
  H5T_bkg_t = Integer;
  PH5T_bkg_t = ^H5T_bkg_t;
const
  H5T_BKG_NO = 0;  (* background buffer is not needed, send NULL *)
  H5T_BKG_TEMP = 1;  (* bkg buffer used as temp storage only *)
  H5T_BKG_YES = 2;  (* init bkg buf with data before conversion *)

(* Type conversion client data *)
type
  PPH5T_cdata_t = ^PH5T_cdata_t;
  PH5T_cdata_t = Pointer;

(* Conversion function persistence *)
type
  H5T_pers_t = Integer;
  PH5T_pers_t = ^H5T_pers_t;
const
  H5T_PERS_DONTCARE = -1;  (* wild card *)
  H5T_PERS_HARD = 0;  (* hard conversion function *)
  H5T_PERS_SOFT = 1;  (* soft conversion function *)

(* The order to retrieve atomic native datatype *)
type
  H5T_direction_t = Integer;
  PH5T_direction_t = ^H5T_direction_t;
const
  H5T_DIR_DEFAULT = 0;  (* default direction is inscendent *)
  H5T_DIR_ASCEND = 1;  (* in inscendent order *)
  H5T_DIR_DESCEND = 2;  (* in descendent order *)

(* The exception type passed into the conversion callback function *)
type
  H5T_conv_except_t = Integer;
  PH5T_conv_except_t = ^H5T_conv_except_t;
const
  H5T_CONV_EXCEPT_RANGE_HI = 0;  (* source value is greater than destination's range *)
  H5T_CONV_EXCEPT_RANGE_LOW = 1;  (* source value is less than destination's range *)
  H5T_CONV_EXCEPT_PRECISION = 2;  (* source value loses precision in destination *)
  H5T_CONV_EXCEPT_TRUNCATE = 3;  (* source value is truncated in destination *)
  H5T_CONV_EXCEPT_PINF = 4;  (* source value is positive infinity(floating number) *)
  H5T_CONV_EXCEPT_NINF = 5;  (* source value is negative infinity(floating number) *)
  H5T_CONV_EXCEPT_NAN = 6;  (* source value is NaN(floating number) *)

(* The return value from conversion callback function H5T_conv_except_func_t *)
type
  H5T_conv_ret_t = Integer;
  PH5T_conv_ret_t = ^H5T_conv_ret_t;
const
  H5T_CONV_ABORT = -1;  (* abort conversion *)
  H5T_CONV_UNHANDLED = 0;  (* callback function failed to handle the exception *)
  H5T_CONV_HANDLED = 1;  (* callback function handled the exception successfully *)

(* Variable Length Datatype struct in memory *)
(* (This is only used for VL sequences, not VL strings, which are stored in char *'s) *)
type
  PPhvl_t = ^Phvl_t;
  Phvl_t = Pointer;

(* Variable Length String information *)
const
  H5T_VARIABLE = size_t(-1);  (* Indicate that a string is variable length (null-terminated in C, instead of fixed length) *)

(* Opaque information *)
const
  H5T_OPAQUE_TAG_MAX = 256;  (* Maximum length of an opaque tag *)
(* This could be raised without too much difficulty *)

(* All datatype conversion functions are... *)
type
  H5T_conv_t = function(src_id: hid_t; dst_id: hid_t; cdata: PH5T_cdata_t; nelmts: size_t; buf_stride: size_t; bkg_stride: size_t; buf: Pointer; bkg: Pointer; dset_xfer_plist: hid_t): herr_t; cdecl;
  PH5T_conv_t = ^H5T_conv_t;

(* Exception handler.  If an exception like overflow happenes during conversion,
 * this function is called if it's registered through H5Pset_type_conv_cb.
 *)
type
  H5T_conv_except_func_t = function(except_type: H5T_conv_except_t; src_id: hid_t; dst_id: hid_t; src_buf: Pointer; dst_buf: Pointer; user_data: Pointer): H5T_conv_ret_t; cdecl;
  PH5T_conv_except_func_t = ^H5T_conv_except_func_t;
const
  H5AC__CURR_CACHE_CONFIG_VERSION = 1;
  H5AC__MAX_TRACE_FILE_NAME_LEN = 1024;
const
  H5AC_METADATA_WRITE_STRATEGY__PROCESS_0_ONLY = 0;
  H5AC_METADATA_WRITE_STRATEGY__DISTRIBUTED = 1;
type
  PPH5AC_cache_config_t = ^PH5AC_cache_config_t;
  PH5AC_cache_config_t = Pointer;

(* Macros used to "unset" chunk cache configuration parameters *)
const
  H5D_CHUNK_CACHE_NSLOTS_DEFAULT = size_t(-1);
  H5D_CHUNK_CACHE_NBYTES_DEFAULT = size_t(-1);
  H5D_CHUNK_CACHE_W0_DEFAULT = -1.0;

(* Property names for H5LTDdirect_chunk_write *)
const
  H5D_XFER_DIRECT_CHUNK_WRITE_FLAG_NAME = 'direct_chunk_flag';
  H5D_XFER_DIRECT_CHUNK_WRITE_FILTERS_NAME = 'direct_chunk_filters';
  H5D_XFER_DIRECT_CHUNK_WRITE_OFFSET_NAME = 'direct_chunk_offset';
  H5D_XFER_DIRECT_CHUNK_WRITE_DATASIZE_NAME = 'direct_chunk_datasize';

(* Values for the H5D_LAYOUT property *)
type
  H5D_layout_t = Integer;
  PH5D_layout_t = ^H5D_layout_t;
const
  H5D_LAYOUT_ERROR = -1;

  H5D_COMPACT = 0;  (* raw data is very small *)
  H5D_CONTIGUOUS = 1;  (* the default *)
  H5D_CHUNKED = 2;  (* slow and fancy *)
  H5D_NLAYOUTS = 3;  (* this one must be last! *)

(* Types of chunk index data structures *)
type
  H5D_chunk_index_t = Integer;
  PH5D_chunk_index_t = ^H5D_chunk_index_t;
const
  H5D_CHUNK_BTREE = 0;  (* v1 B-tree index *)

(* Values for the space allocation time property *)
type
  H5D_alloc_time_t = Integer;
  PH5D_alloc_time_t = ^H5D_alloc_time_t;
const
  H5D_ALLOC_TIME_ERROR = -1;
  H5D_ALLOC_TIME_DEFAULT = 0;
  H5D_ALLOC_TIME_EARLY = 1;
  H5D_ALLOC_TIME_LATE = 2;
  H5D_ALLOC_TIME_INCR = 3;

(* Values for the status of space allocation *)
type
  H5D_space_status_t = Integer;
  PH5D_space_status_t = ^H5D_space_status_t;
const
  H5D_SPACE_STATUS_ERROR = -1;
  H5D_SPACE_STATUS_NOT_ALLOCATED = 0;
  H5D_SPACE_STATUS_PART_ALLOCATED = 1;
  H5D_SPACE_STATUS_ALLOCATED = 2;

(* Values for time of writing fill value property *)
type
  H5D_fill_time_t = Integer;
  PH5D_fill_time_t = ^H5D_fill_time_t;
const
  H5D_FILL_TIME_ERROR = -1;
  H5D_FILL_TIME_ALLOC = 0;
  H5D_FILL_TIME_NEVER = 1;
  H5D_FILL_TIME_IFSET = 2;

(* Values for fill value status *)
type
  H5D_fill_value_t = Integer;
  PH5D_fill_value_t = ^H5D_fill_value_t;
const
  H5D_FILL_VALUE_ERROR = -1;
  H5D_FILL_VALUE_UNDEFINED = 0;
  H5D_FILL_VALUE_DEFAULT = 1;
  H5D_FILL_VALUE_USER_DEFINED = 2;

(* Define the operator function pointer for H5Diterate() *)
type
  H5D_operator_t = function(elem: Pointer; type_id: hid_t; ndim: Cardinal; point: Phsize_t; operator_data: Pointer): herr_t; cdecl;
  PH5D_operator_t = ^H5D_operator_t;

(* Define the operator function pointer for H5Dscatter() *)
type
  H5D_scatter_func_t = function(src_buf: PPointer; src_buf_bytes_used: Psize_t; op_data: Pointer): herr_t; cdecl;
  PH5D_scatter_func_t = ^H5D_scatter_func_t;

(* Define the operator function pointer for H5Dgather() *)
type
  H5D_gather_func_t = function(dst_buf: Pointer; dst_buf_bytes_used: size_t; op_data: Pointer): herr_t; cdecl;
  PH5D_gather_func_t = ^H5D_gather_func_t;

(* Value for the default error stack *)
const
  H5E_DEFAULT = hid_t(0);

(* Different kinds of error information *)
type
  H5E_type_t = Integer;
  PH5E_type_t = ^H5E_type_t;
const
  H5E_MAJOR = 0;
  H5E_MINOR = 1;

(* Information about an error; element of error stack *)
type
  PPH5E_error2_t = ^PH5E_error2_t;
  PH5E_error2_t = Pointer;

(* Error stack traversal direction *)
type
  H5E_direction_t = Integer;
  PH5E_direction_t = ^H5E_direction_t;
const
  H5E_WALK_UPWARD = 0;  (* begin deep, end at API function *)
  H5E_WALK_DOWNWARD = 1;  (* begin at API function, end deep *)

(* Error stack traversal callback function pointers *)
type
  H5E_walk2_t = function(n: Cardinal; err_desc: PH5E_error2_t; client_data: Pointer): herr_t; cdecl;
  PH5E_walk2_t = ^H5E_walk2_t;
  H5E_auto2_t = function(estack: hid_t; client_data: Pointer): herr_t; cdecl;
  PH5E_auto2_t = ^H5E_auto2_t;

(* Define atomic datatypes *)
const
  H5S_ALL = hid_t(0);
  H5S_UNLIMITED = hsize_t(hssize_t(-1));

(* Define user-level maximum number of dimensions *)
const
  H5S_MAX_RANK = 32;

(* Different types of dataspaces *)
type
  H5S_class_t = Integer;
  PH5S_class_t = ^H5S_class_t;
const
  H5S_NO_CLASS = -1;  (* error *)
  H5S_SCALAR = 0;  (* scalar variable *)
  H5S_SIMPLE = 1;  (* simple data space *)
  H5S_NULL = 2;  (* null data space *)

(* Different ways of combining selections *)
type
  H5S_seloper_t = Integer;
  PH5S_seloper_t = ^H5S_seloper_t;
const
  H5S_SELECT_NOOP = -1;  (* error *)
  H5S_SELECT_SET = 0;  (* Select "set" operation *)
  H5S_SELECT_OR = 1;
(* Binary "or" operation for hyperslabs
 * (add new selection to existing selection)
 * Original region:  AAAAAAAAAA
 * New region:             BBBBBBBBBB
 * A or B:           CCCCCCCCCCCCCCCC
 *)
  H5S_SELECT_AND = 2;
(* Binary "and" operation for hyperslabs
 * (only leave overlapped regions in selection)
 * Original region:  AAAAAAAAAA
 * New region:             BBBBBBBBBB
 * A and B:                CCCC
 *)
  H5S_SELECT_XOR = 3;
(* Binary "xor" operation for hyperslabs
 * (only leave non-overlapped regions in selection)
 * Original region:  AAAAAAAAAA
 * New region:             BBBBBBBBBB
 * A xor B:          CCCCCC    CCCCCC
 *)
  H5S_SELECT_NOTB = 4;
(* Binary "not" operation for hyperslabs
 * (only leave non-overlapped regions in original selection)
 * Original region:  AAAAAAAAAA
 * New region:             BBBBBBBBBB
 * A not B:          CCCCCC
 *)
  H5S_SELECT_NOTA = 5;
(* Binary "not" operation for hyperslabs
 * (only leave non-overlapped regions in new selection)
 * Original region:  AAAAAAAAAA
 * New region:             BBBBBBBBBB
 * B not A:                    CCCCCC
 *)
  H5S_SELECT_APPEND = 6;  (* Append elements to end of point selection *)
  H5S_SELECT_PREPEND = 7;  (* Prepend elements to beginning of point selection *)
  H5S_SELECT_INVALID = 8;  (* Invalid upper bound on selection operations *)

(* Enumerated type for the type of selection *)
type
  H5S_sel_type = Integer;
  PH5S_sel_type = ^H5S_sel_type;
const
  H5S_SEL_ERROR = -1;  (* Error *)
  H5S_SEL_NONE = 0;  (* Nothing selected *)
  H5S_SEL_POINTS = 1;  (* Sequence of points selected *)
  H5S_SEL_HYPERSLABS = 2;  (* "New-style" hyperslab selection defined *)
  H5S_SEL_ALL = 3;  (* Entire extent selected *)
  H5S_SEL_N = 4;  (* THIS MUST BE LAST *)

(* Maximum length of a link's name *)
(* (encoded in a 32-bit unsigned integer) *)
const
  H5L_MAX_LINK_NAME_LEN = uint32_t(-1);  (* (4GB - 1) *)

(* Macro to indicate operation occurs on same location *)
const
  H5L_SAME_LOC = hid_t(0);

(* Current version of the H5L_class_t struct *)
const
  H5L_LINK_CLASS_T_VERS = 0;

(* Link class types.
 * Values less than 64 are reserved for the HDF5 library's internal use.
 * Values 64 to 255 are for "user-defined" link class types; these types are
 * defined by HDF5 but their behavior can be overridden by users.
 * Users who want to create new classes of links should contact the HDF5
 * development team at hdfhelp@ncsa.uiuc.edu .
 * These values can never change because they appear in HDF5 files.
 *)
type
  H5L_type_t = Integer;
  PH5L_type_t = ^H5L_type_t;
const
  H5L_TYPE_ERROR = -1;  (* Invalid link type id *)
  H5L_TYPE_HARD = 0;  (* Hard link id *)
  H5L_TYPE_SOFT = 1;  (* Soft link id *)
  H5L_TYPE_EXTERNAL = 64;  (* External link id *)
  H5L_TYPE_MAX = 255;  (* Maximum link type id *)
const
  H5L_TYPE_BUILTIN_MAX = H5L_TYPE_SOFT;  (* Maximum value link value for "built-in" link types *)
  H5L_TYPE_UD_MIN = H5L_TYPE_EXTERNAL;  (* Link ids at or above this value are "user-defined" link types. *)

(* Information struct for link (for H5Lget_info/H5Lget_info_by_idx) *)
type
  PPH5L_info_t = ^PH5L_info_t;
  PH5L_info_t = Pointer;

(* The H5L_class_t struct can be used to override the behavior of a
 * "user-defined" link class. Users should populate the struct with callback
 * functions defined below.
 *)
(* Callback prototypes for user-defined links *)
(* Link creation callback *)
type
  H5L_create_func_t = function(link_name: PAnsiChar; loc_group: hid_t; lnkdata: Pointer; lnkdata_size: size_t; lcpl_id: hid_t): herr_t; cdecl;
  PH5L_create_func_t = ^H5L_create_func_t;

(* Callback for when the link is moved *)
type
  H5L_move_func_t = function(new_name: PAnsiChar; new_loc: hid_t; lnkdata: Pointer; lnkdata_size: size_t): herr_t; cdecl;
  PH5L_move_func_t = ^H5L_move_func_t;

(* Callback for when the link is copied *)
type
  H5L_copy_func_t = function(new_name: PAnsiChar; new_loc: hid_t; lnkdata: Pointer; lnkdata_size: size_t): herr_t; cdecl;
  PH5L_copy_func_t = ^H5L_copy_func_t;

(* Callback during link traversal *)
type
  H5L_traverse_func_t = function(link_name: PAnsiChar; cur_group: hid_t; lnkdata: Pointer; lnkdata_size: size_t; lapl_id: hid_t): hid_t; cdecl;
  PH5L_traverse_func_t = ^H5L_traverse_func_t;

(* Callback for when the link is deleted *)
type
  H5L_delete_func_t = function(link_name: PAnsiChar; file_: hid_t; lnkdata: Pointer; lnkdata_size: size_t): herr_t; cdecl;
  PH5L_delete_func_t = ^H5L_delete_func_t;

(* Callback for querying the link *)
(* Returns the size of the buffer needed *)
type
  H5L_query_func_t = function(link_name: PAnsiChar; lnkdata: Pointer; lnkdata_size: size_t; buf: Pointer; buf_size: size_t): ssize_t; cdecl;
  PH5L_query_func_t = ^H5L_query_func_t;

(* User-defined link types *)
type
  PPH5L_class_t = ^PH5L_class_t;
  PH5L_class_t = Pointer;

(* Prototype for H5Literate/H5Literate_by_name() operator *)
type
  H5L_iterate_t = function(group: hid_t; name: PAnsiChar; info: PH5L_info_t; op_data: Pointer): herr_t; cdecl;
  PH5L_iterate_t = ^H5L_iterate_t;

(* Callback for external link traversal *)
type
  H5L_elink_traverse_t = function(parent_file_name: PAnsiChar; parent_group_name: PAnsiChar; child_file_name: PAnsiChar; child_object_name: PAnsiChar; acc_flags: PCardinal; fapl_id: hid_t; op_data: Pointer): herr_t; cdecl;
  PH5L_elink_traverse_t = ^H5L_elink_traverse_t;

(* Flags for object copy (H5Ocopy) *)
const
  H5O_COPY_SHALLOW_HIERARCHY_FLAG = 1;  (* Copy only immediate members *)
  H5O_COPY_EXPAND_SOFT_LINK_FLAG = 2;  (* Expand soft links into new objects *)
  H5O_COPY_EXPAND_EXT_LINK_FLAG = 4;  (* Expand external links into new objects *)
  H5O_COPY_EXPAND_REFERENCE_FLAG = 8;  (* Copy objects that are pointed by references *)
  H5O_COPY_WITHOUT_ATTR_FLAG = 16;  (* Copy object without copying attributes *)
  H5O_COPY_PRESERVE_NULL_FLAG = 32;  (* Copy NULL messages (empty space) *)
  H5O_COPY_MERGE_COMMITTED_DTYPE_FLAG = 64;  (* Merge committed datatypes in dest file *)
  H5O_COPY_ALL = 127;  (* All object copying flags (for internal checking) *)

(* Flags for shared message indexes.
 * Pass these flags in using the mesg_type_flags parameter in
 * H5P_set_shared_mesg_index.
 * (Developers: These flags correspond to object header message type IDs,
 * but we need to assign each kind of message to a different bit so that
 * one index can hold multiple types.)
 *)
const
  H5O_SHMESG_NONE_FLAG = 0;  (* No shared messages *)
  H5O_SHMESG_SDSPACE_FLAG = 1 shl 1;  (* Simple Dataspace Message. *)
  H5O_SHMESG_DTYPE_FLAG = 1 shl 3;  (* Datatype Message. *)
  H5O_SHMESG_FILL_FLAG = 1 shl 5;  (* Fill Value Message. *)
  H5O_SHMESG_PLINE_FLAG = 1 shl 11;  (* Filter pipeline message. *)
  H5O_SHMESG_ATTR_FLAG = 1 shl 12;  (* Attribute Message. *)
  H5O_SHMESG_ALL_FLAG = H5O_SHMESG_SDSPACE_FLAG or H5O_SHMESG_DTYPE_FLAG or H5O_SHMESG_FILL_FLAG or H5O_SHMESG_PLINE_FLAG or H5O_SHMESG_ATTR_FLAG;

(* Object header status flag definitions *)
const
  H5O_HDR_CHUNK0_SIZE = 3;  (* 2-bit field indicating # of bytes to store the size of chunk 0's data *)
  H5O_HDR_ATTR_CRT_ORDER_TRACKED = 4;  (* Attribute creation order is tracked *)
  H5O_HDR_ATTR_CRT_ORDER_INDEXED = 8;  (* Attribute creation order has index *)
  H5O_HDR_ATTR_STORE_PHASE_CHANGE = 16;  (* Non-default attribute storage phase change values stored *)
  H5O_HDR_STORE_TIMES = 32;  (* Store access, modification, change & birth times for object *)
  H5O_HDR_ALL_FLAGS = H5O_HDR_CHUNK0_SIZE or H5O_HDR_ATTR_CRT_ORDER_TRACKED or H5O_HDR_ATTR_CRT_ORDER_INDEXED or H5O_HDR_ATTR_STORE_PHASE_CHANGE or H5O_HDR_STORE_TIMES;

(* Maximum shared message values.  Number of indexes is 8 to allow room to add
 * new types of messages.
 *)
const
  H5O_SHMESG_MAX_NINDEXES = 8;
  H5O_SHMESG_MAX_LIST_SIZE = 5000;

(* Types of objects in file *)
type
  H5O_type_t = Integer;
  PH5O_type_t = ^H5O_type_t;
const
  H5O_TYPE_UNKNOWN = -1;  (* Unknown object type *)
  H5O_TYPE_GROUP = 0;  (* Object is a group *)
  H5O_TYPE_DATASET = 1;  (* Object is a dataset *)
  H5O_TYPE_NAMED_DATATYPE = 2;  (* Object is a named data type *)
  H5O_TYPE_NTYPES = 3;  (* Number of different object types (must be last!) *)

(* Information struct for object header metadata (for H5Oget_info/H5Oget_info_by_name/H5Oget_info_by_idx) *)
type
TSpace=record
        total: hsize_t;		//* Total space for storing object header in file */
         meta: hsize_t;		//* Space within header for object header metadata information */
         mesg: hsize_t;		//* Space within header for actual message information */
         free: hsize_t;		//* Free space within object header */
end;
Tmesg=record
       present: UINT64;	//* Flags to indicate presence of message type in header */
       shared: UINT64;	//* Flags to indicate message type is shared in header */
end;

TH5O_hdr_info_t=record
    version: Cardinal;		//* Version number of header format in file */
    nmesgs: Cardinal;		//* Number of object header messages */
    nchunks: Cardinal;		//* Number of object header chunks */
    flags: Cardinal;             //* Object header status flags */
    space: TSpace;
    mesg: Tmesg;
end;

PH5O_hdr_info_t = ^TH5O_hdr_info_t;

Tmeta_size=record
      obj: H5_ih_info_t;             //* v1/v2 B-tree & local/fractal heap for groups, B-tree for chunked datasets */
      attr: H5_ih_info_t;            //* v2 B-tree & heap for attributes */
end;

(* Information struct for object (for H5Oget_info/H5Oget_info_by_name/H5Oget_info_by_idx) *)
type
H5O_info_t=record
    fileno: Cardinal;		//* File number that object is located in */
    addr: haddr_t;		//* Object address in file	*/
    typ: H5O_type_t;		//* Basic object type (group, dataset, etc.) */
    rc: Cardinal;		//* Reference count of object    */
    atime: time_t;		//* Access time			*/
    mtime: time_t;		//* Modification time		*/
    ctime: time_t;		//* Change time			*/
    btime: time_t;		//* Birth time			*/
    num_attrs: hsize_t;	//* # of attributes attached to object */ hsize_t
    hdr: TH5O_hdr_info_t;            //* Object header information */
    ///* Extra metadata storage for obj & attributes */
    meta_size: Tmeta_size;
end;

  PH5O_info_t = ^H5O_info_t;

(* Typedef for message creation indexes *)
type
  H5O_msg_crt_idx_t = uint32_t;
  PH5O_msg_crt_idx_t = ^H5O_msg_crt_idx_t;

(* Prototype for H5Ovisit/H5Ovisit_by_name() operator *)
type
  H5O_iterate_t = function(obj: hid_t; name: PAnsiChar; info: PH5O_info_t; op_data: Pointer): herr_t; cdecl;
  PH5O_iterate_t = ^H5O_iterate_t;
type
  H5O_mcdt_search_ret_t = Integer;
  PH5O_mcdt_search_ret_t = ^H5O_mcdt_search_ret_t;
const
  H5O_MCDT_SEARCH_ERROR = -1;  (* Abort H5Ocopy *)
  H5O_MCDT_SEARCH_CONT = 0;  (* Continue the global search of all committed datatypes in the destination file *)
  H5O_MCDT_SEARCH_STOP = 1;  (* Stop the search, but continue copying.  The committed datatype will be copied but not merged. *)

(* Callback to invoke when completing the search for a matching committed datatype from the committed dtype list *)
type
  H5O_mcdt_search_cb_t = function(op_data: Pointer): H5O_mcdt_search_ret_t; cdecl;
  PH5O_mcdt_search_cb_t = ^H5O_mcdt_search_cb_t;

(*
 * These are the bits that can be passed to the `flags' argument of
 * H5Fcreate() and H5Fopen(). Use the bit-wise OR operator (|) to combine
 * them as needed.  As a side effect, they call H5check_version() to make sure
 * that the application is compiled with a version of the hdf5 header files
 * which are compatible with the library to which the application is linked.
 * We're assuming that these constants are used rather early in the hdf5
 * session.
 *
 *)
const
  H5F_ACC_RDONLY = 0;  (* absence of rdwr => rd-only *)
  H5F_ACC_RDWR = 1;  (* open for read and write *)
  H5F_ACC_TRUNC = 2;  (* overwrite existing files *)
  H5F_ACC_EXCL = 4;  (* fail if file already exists *)
  H5F_ACC_DEBUG = 8;  (* print debug info *)
  H5F_ACC_CREAT = 16;  (* create non-existing files *)

(* Value passed to H5Pset_elink_acc_flags to cause flags to be taken from the
 * parent file. *)
const
  H5F_ACC_DEFAULT = 65535;  (* ignore setting on lapl *)

(* Flags for H5Fget_obj_count() & H5Fget_obj_ids() calls *)
const
  H5F_OBJ_FILE = 1;  (* File objects *)
  H5F_OBJ_DATASET = 2;  (* Dataset objects *)
  H5F_OBJ_GROUP = 4;  (* Group objects *)
  H5F_OBJ_DATATYPE = 8;  (* Named datatype objects *)
  H5F_OBJ_ATTR = 16;  (* Attribute objects *)
  H5F_OBJ_ALL = H5F_OBJ_FILE or H5F_OBJ_DATASET or H5F_OBJ_GROUP or H5F_OBJ_DATATYPE or H5F_OBJ_ATTR;
  H5F_OBJ_LOCAL = 32;  (* Restrict search to objects opened through current file ID *)
(* (as opposed to objects opened through any file ID accessing this file) *)
const
  H5F_FAMILY_DEFAULT = hsize_t(0);

(* The difference between a single file and a set of mounted files *)
type
  H5F_scope_t = Integer;
  PH5F_scope_t = ^H5F_scope_t;
const
  H5F_SCOPE_LOCAL = 0;  (* specified file handle only *)
  H5F_SCOPE_GLOBAL = 1;  (* entire virtual file *)

(* Unlimited file size for H5Pset_external() *)
const
  H5F_UNLIMITED = hsize_t(-1);

(* How does file close behave?
 * H5F_CLOSE_DEFAULT - Use the degree pre-defined by underlining VFL
 * H5F_CLOSE_WEAK    - file closes only after all opened objects are closed
 * H5F_CLOSE_SEMI    - if no opened objects, file is close; otherwise, file
                       close fails
 * H5F_CLOSE_STRONG  - if there are opened objects, close them first, then
                       close file
 *)
type
  H5F_close_degree_t = Integer;
  PH5F_close_degree_t = ^H5F_close_degree_t;
const
  H5F_CLOSE_DEFAULT = 0;
  H5F_CLOSE_WEAK = 1;
  H5F_CLOSE_SEMI = 2;
  H5F_CLOSE_STRONG = 3;

(* Current "global" information about file *)
(* (just size info currently) *)
type
  PPH5F_info_t = ^PH5F_info_t;
  PH5F_info_t = Pointer;

(*
 * Types of allocation requests. The values larger than H5FD_MEM_DEFAULT
 * should not change other than adding new types to the end. These numbers
 * might appear in files.
 *
 * Note: please change the log VFD flavors array if you change this
 * enumeration.
 *)
type
  H5F_mem_t = Integer;
  PH5F_mem_t = ^H5F_mem_t;
const
  H5FD_MEM_NOLIST = -1;
(* Data should not appear in the free list.
 * Must be negative.
 *)
  H5FD_MEM_DEFAULT = 0;
(* Value not yet set.  Can also be the
 * datatype set in a larger allocation
 * that will be suballocated by the library.
 * Must be zero.
 *)
  H5FD_MEM_SUPER = 1;  (* Superblock data *)
  H5FD_MEM_BTREE = 2;  (* B-tree data *)
  H5FD_MEM_DRAW = 3;  (* Raw data (content of datasets, etc.) *)
  H5FD_MEM_GHEAP = 4;  (* Global heap data *)
  H5FD_MEM_LHEAP = 5;  (* Local heap data *)
  H5FD_MEM_OHDR = 6;  (* Object header data *)

  H5FD_MEM_NTYPES = 7;  (* Sentinel value - must be last *)

(* Library's file format versions *)
type
  H5F_libver_t = Integer;
  PH5F_libver_t = ^H5F_libver_t;
const
  H5F_LIBVER_EARLIEST = 0;  (* Use the earliest possible format for storing objects *)
  H5F_LIBVER_LATEST = 1;  (* Use the latest possible format available for storing objects *)

(* Define file format version for 1.8 to prepare for 1.10 release.
 * (Not used anywhere now)*)
const
  H5F_LIBVER_18 = H5F_LIBVER_LATEST;

(* Information struct for attribute (for H5Aget_info/H5Aget_info_by_idx) *)
type
  PPH5A_info_t = ^PH5A_info_t;
  PH5A_info_t = Pointer;

(* Typedef for H5Aiterate2() callbacks *)
type
  H5A_operator2_t = function(location_id: hid_t; attr_name: PAnsiChar; ainfo: PH5A_info_t; op_data: Pointer): herr_t; cdecl;
  PH5A_operator2_t = ^H5A_operator2_t;
const
  H5_HAVE_VFL = 1;  (* define a convenient app feature test *)
  H5FD_VFD_DEFAULT = 0;  (* Default VFL driver value *)

(* Types of allocation requests: see H5Fpublic.h  *)
type
  H5FD_mem_t = H5F_mem_t;
  PH5FD_mem_t = ^H5FD_mem_t;

(* Map "fractal heap" header blocks to 'ohdr' type file memory, since its
 * a fair amount of work to add a new kind of file memory and they are similar
 * enough to object headers and probably too minor to deserve their own type.
 *
 * Map "fractal heap" indirect blocks to 'ohdr' type file memory, since they
 * are similar to fractal heap header blocks.
 *
 * Map "fractal heap" direct blocks to 'lheap' type file memory, since they
 * will be replacing local heaps.
 *
 * Map "fractal heap" 'huge' objects to 'draw' type file memory, since they
 * represent large objects that are directly stored in the file.
 *
 *      -QAK
 *)
const
  H5FD_MEM_FHEAP_HDR = H5FD_MEM_OHDR;
  H5FD_MEM_FHEAP_IBLOCK = H5FD_MEM_OHDR;
  H5FD_MEM_FHEAP_DBLOCK = H5FD_MEM_LHEAP;
  H5FD_MEM_FHEAP_HUGE_OBJ = H5FD_MEM_DRAW;

(* Map "free space" header blocks to 'ohdr' type file memory, since its
 * a fair amount of work to add a new kind of file memory and they are similar
 * enough to object headers and probably too minor to deserve their own type.
 *
 * Map "free space" serialized sections to 'lheap' type file memory, since they
 * are similar enough to local heap info.
 *
 *      -QAK
 *)
const
  H5FD_MEM_FSPACE_HDR = H5FD_MEM_OHDR;
  H5FD_MEM_FSPACE_SINFO = H5FD_MEM_LHEAP;

(* Map "shared object header message" master table to 'ohdr' type file memory,
 * since its a fair amount of work to add a new kind of file memory and they are
 * similar enough to object headers and probably too minor to deserve their own
 * type.
 *
 * Map "shared object header message" indices to 'btree' type file memory,
 * since they are similar enough to B-tree nodes.
 *
 *      -QAK
 *)
const
  H5FD_MEM_SOHM_TABLE = H5FD_MEM_OHDR;
  H5FD_MEM_SOHM_INDEX = H5FD_MEM_BTREE;

(* Define VFL driver features that can be enabled on a per-driver basis *)
(* These are returned with the 'query' function pointer in H5FD_class_t *)
    (*
     * Defining the H5FD_FEAT_AGGREGATE_METADATA for a VFL driver means that
     * the library will attempt to allocate a larger block for metadata and
     * then sub-allocate each metadata request from that larger block.
     *)
const
  H5FD_FEAT_AGGREGATE_METADATA = 1;
(*
 * Defining the H5FD_FEAT_ACCUMULATE_METADATA for a VFL driver means that
 * the library will attempt to cache metadata as it is written to the file
 * and build up a larger block of metadata to eventually pass to the VFL
 * 'write' routine.
 *
 * Distinguish between updating the metadata accumulator on writes and
 * reads.  This is particularly (perhaps only, even) important for MPI-I/O
 * where we guarantee that writes are collective, but reads may not be.
 * If we were to allow the metadata accumulator to be written during a
 * read operation, the application would hang.
 *)
  H5FD_FEAT_ACCUMULATE_METADATA_WRITE = 2;
  H5FD_FEAT_ACCUMULATE_METADATA_READ = 4;
  H5FD_FEAT_ACCUMULATE_METADATA = H5FD_FEAT_ACCUMULATE_METADATA_WRITE or H5FD_FEAT_ACCUMULATE_METADATA_READ;
(*
 * Defining the H5FD_FEAT_DATA_SIEVE for a VFL driver means that
 * the library will attempt to cache raw data as it is read from/written to
 * a file in a "data seive" buffer.  See Rajeev Thakur's papers:
 *  http://www.mcs.anl.gov/~thakur/papers/romio-coll.ps.gz
 *  http://www.mcs.anl.gov/~thakur/papers/mpio-high-perf.ps.gz
 *)
  H5FD_FEAT_DATA_SIEVE = 8;
(*
 * Defining the H5FD_FEAT_AGGREGATE_SMALLDATA for a VFL driver means that
 * the library will attempt to allocate a larger block for "small" raw data
 * and then sub-allocate "small" raw data requests from that larger block.
 *)
  H5FD_FEAT_AGGREGATE_SMALLDATA = 16;
(*
 * Defining the H5FD_FEAT_IGNORE_DRVRINFO for a VFL driver means that
 * the library will ignore the driver info that is encoded in the file
 * for the VFL driver.  (This will cause the driver info to be eliminated
 * from the file when it is flushed/closed, if the file is opened R/W).
 *)
  H5FD_FEAT_IGNORE_DRVRINFO = 32;
(*
 * Defining the H5FD_FEAT_DIRTY_SBLK_LOAD for a VFL driver means that
 * the library will mark the superblock dirty when the file is opened
 * R/W.  This will cause the driver info to be re-encoded when the file
 * is flushed/closed.
 *)
  H5FD_FEAT_DIRTY_SBLK_LOAD = 64;
(*
 * Defining the H5FD_FEAT_POSIX_COMPAT_HANDLE for a VFL driver means that
 * the handle for the VFD (returned with the 'get_handle' callback) is
 * of type 'int' and is compatible with POSIX I/O calls.
 *)
  H5FD_FEAT_POSIX_COMPAT_HANDLE = 128;
(*
 * Defining the H5FD_FEAT_ALLOW_FILE_IMAGE for a VFL driver means that
 * the driver is able to use a file image in the fapl as the initial
 * contents of a file.
 *)
  H5FD_FEAT_ALLOW_FILE_IMAGE = 1024;
(*
 * Defining the H5FD_FEAT_CAN_USE_FILE_IMAGE_CALLBACKS for a VFL driver
 * means that the driver is able to use callbacks to make a copy of the
 * image to store in memory.
 *)
  H5FD_FEAT_CAN_USE_FILE_IMAGE_CALLBACKS = 2048;

(* Class information for each file driver *)
type
  PPH5FD_class_t = ^PH5FD_class_t;
  PH5FD_class_t = Pointer;

(* A free list is a singly-linked list of address/size pairs. *)
type
  PPH5FD_free_t = ^PH5FD_free_t;
  PH5FD_free_t = Pointer;

(*
 * The main datatype for each driver. Public fields common to all drivers
 * are declared here and the driver appends private fields in memory.
*)
type
  PPH5FD_t = ^PH5FD_t;
  PH5FD_t = Pointer;

(* Define enum for the source of file image callbacks *)
type
  H5FD_file_image_op_t = Integer;
  PH5FD_file_image_op_t = ^H5FD_file_image_op_t;
const
  H5FD_FILE_IMAGE_OP_NO_OP = 0;
  H5FD_FILE_IMAGE_OP_PROPERTY_LIST_SET = 1;
  H5FD_FILE_IMAGE_OP_PROPERTY_LIST_COPY = 2;
  H5FD_FILE_IMAGE_OP_PROPERTY_LIST_GET = 3;
  H5FD_FILE_IMAGE_OP_PROPERTY_LIST_CLOSE = 4;
  H5FD_FILE_IMAGE_OP_FILE_OPEN = 5;
  H5FD_FILE_IMAGE_OP_FILE_RESIZE = 6;
  H5FD_FILE_IMAGE_OP_FILE_CLOSE = 7;

(* Define structure to hold file image callbacks *)
type
  PPH5FD_file_image_callbacks_t = ^PH5FD_file_image_callbacks_t;
  PH5FD_file_image_callbacks_t = Pointer;

(* Types of link storage for groups *)
type
  H5G_storage_type_t = Integer;
  PH5G_storage_type_t = ^H5G_storage_type_t;
const
  H5G_STORAGE_TYPE_UNKNOWN = -1;  (* Unknown link storage type *)
  H5G_STORAGE_TYPE_SYMBOL_TABLE = 0;  (* Links in group are stored with a "symbol table" *)
(* (this is sometimes called "old-style" groups) *)
  H5G_STORAGE_TYPE_COMPACT = 1;  (* Links are stored in object header *)
  H5G_STORAGE_TYPE_DENSE = 2;  (* Links are stored in fractal heap & indexed with v2 B-tree *)

(* Information struct for group (for H5Gget_info/H5Gget_info_by_name/H5Gget_info_by_idx) *)
type
  PPH5G_info_t = ^PH5G_info_t;
  PH5G_info_t = Pointer;

(*
 * Reference types allowed.
 *)
type
  H5R_type_t = Integer;
  PH5R_type_t = ^H5R_type_t;
const
  H5R_BADTYPE = -1;  (* invalid Reference Type *)
  H5R_OBJECT = 0;  (* Object reference *)
  H5R_DATASET_REGION = 1;  (* Dataset Region Reference *)
  H5R_MAXTYPE = 2;  (* highest type (Invalid as true type) *)

(* Note! Be careful with the sizes of the references because they should really
 * depend on the run-time values in the file.  Unfortunately, the arrays need
 * to be defined at compile-time, so we have to go with the worst case sizes for
 * them.  -QAK
 *)
const
  H5R_OBJ_REF_BUF_SIZE = SizeOf(haddr_t);
(* Object reference structure for user's code *)
type
  hobj_ref_t = haddr_t;
  Phobj_ref_t = ^hobj_ref_t;
const
  H5R_DSET_REG_REF_BUF_SIZE = SizeOf(haddr_t)+4;
(* 4 is used instead of sizeof(int) to permit portability between
   the Crays and other machines (the heap ID is always encoded as an int32 anyway)
*)
(* Dataset Region reference structure for user's code *)
type
  Phdset_reg_ref_t = PByte;
(* Needs to be large enough to store largest haddr_t in a worst case machine (ie. 8 bytes currently) plus an int *)

(* Common creation order flags (for links in groups and attributes on objects) *)
const
  H5P_CRT_ORDER_TRACKED = 1;
  H5P_CRT_ORDER_INDEXED = 2;

(* Default value for all property list classes *)
const
  H5P_DEFAULT = hid_t(0);

(* Define property list class callback function pointer types *)
type
  H5P_cls_create_func_t = function(prop_id: hid_t; create_data: Pointer): herr_t; cdecl;
  PH5P_cls_create_func_t = ^H5P_cls_create_func_t;
  H5P_cls_copy_func_t = function(new_prop_id: hid_t; old_prop_id: hid_t; copy_data: Pointer): herr_t; cdecl;
  PH5P_cls_copy_func_t = ^H5P_cls_copy_func_t;
  H5P_cls_close_func_t = function(prop_id: hid_t; close_data: Pointer): herr_t; cdecl;
  PH5P_cls_close_func_t = ^H5P_cls_close_func_t;

(* Define property list callback function pointer types *)
type
  H5P_prp_cb1_t = function(name: PAnsiChar; size: size_t; value: Pointer): herr_t; cdecl;
  PH5P_prp_cb1_t = ^H5P_prp_cb1_t;
  H5P_prp_cb2_t = function(prop_id: hid_t; name: PAnsiChar; size: size_t; value: Pointer): herr_t; cdecl;
  PH5P_prp_cb2_t = ^H5P_prp_cb2_t;
  H5P_prp_create_func_t = H5P_prp_cb1_t;
  PH5P_prp_create_func_t = ^H5P_prp_create_func_t;
  H5P_prp_set_func_t = H5P_prp_cb2_t;
  PH5P_prp_set_func_t = ^H5P_prp_set_func_t;
  H5P_prp_get_func_t = H5P_prp_cb2_t;
  PH5P_prp_get_func_t = ^H5P_prp_get_func_t;
  H5P_prp_delete_func_t = H5P_prp_cb2_t;
  PH5P_prp_delete_func_t = ^H5P_prp_delete_func_t;
  H5P_prp_copy_func_t = H5P_prp_cb1_t;
  PH5P_prp_copy_func_t = ^H5P_prp_copy_func_t;
  H5P_prp_compare_func_t = function(value1: Pointer; value2: Pointer; size: size_t): Integer; cdecl;
  PH5P_prp_compare_func_t = ^H5P_prp_compare_func_t;
  H5P_prp_close_func_t = H5P_prp_cb1_t;
  PH5P_prp_close_func_t = ^H5P_prp_close_func_t;

(* Define property list iteration function type *)
type
  H5P_iterate_t = function(id: hid_t; name: PAnsiChar; iter_data: Pointer): herr_t; cdecl;
  PH5P_iterate_t = ^H5P_iterate_t;

(* Actual IO mode property *)
type
  H5D_mpio_actual_chunk_opt_mode_t = Integer;
  PH5D_mpio_actual_chunk_opt_mode_t = ^H5D_mpio_actual_chunk_opt_mode_t;
const
(* The default value, H5D_MPIO_NO_CHUNK_OPTIMIZATION, is used for all I/O
 * operations that do not use chunk optimizations, including non-collective
 * I/O and contiguous collective I/O.
 *)
  H5D_MPIO_NO_CHUNK_OPTIMIZATION = 0;
  H5D_MPIO_LINK_CHUNK = 1;
  H5D_MPIO_MULTI_CHUNK = 2;
type
  H5D_mpio_actual_io_mode_t = Integer;
  PH5D_mpio_actual_io_mode_t = ^H5D_mpio_actual_io_mode_t;
const
(* The following four values are conveniently defined as a bit field so that
 * we can switch from the default to indpendent or collective and then to
 * mixed without having to check the original value.
 *
 * NO_COLLECTIVE means that either collective I/O wasn't requested or that
 * no I/O took place.
 *
 * CHUNK_INDEPENDENT means that collective I/O was requested, but the
 * chunk optimization scheme chose independent I/O for each chunk.
 *)
  H5D_MPIO_NO_COLLECTIVE = 0;
  H5D_MPIO_CHUNK_INDEPENDENT = 1;
  H5D_MPIO_CHUNK_COLLECTIVE = 2;
  H5D_MPIO_CHUNK_MIXED = 3;

(* The contiguous case is separate from the bit field. *)
  H5D_MPIO_CONTIGUOUS_COLLECTIVE = 4;

(* Broken collective IO property *)
type
  H5D_mpio_no_collective_cause_t = Integer;
  PH5D_mpio_no_collective_cause_t = ^H5D_mpio_no_collective_cause_t;
const
  H5D_MPIO_COLLECTIVE = 0;
  H5D_MPIO_SET_INDEPENDENT = 1;
  H5D_MPIO_DATATYPE_CONVERSION = 2;
  H5D_MPIO_DATA_TRANSFORMS = 4;
  H5D_MPIO_MPI_OPT_TYPES_ENV_VAR_DISABLED = 8;
  H5D_MPIO_NOT_SIMPLE_OR_SCALAR_DATASPACES = 16;
  H5D_MPIO_NOT_CONTIGUOUS_OR_CHUNKED_DATASET = 32;
  H5D_MPIO_FILTERS = 64;

type
  THDF5Dll = class
  private
    FHandle: THandle;

    FH5open: function: herr_t; cdecl;
    FH5close: function: herr_t; cdecl;
    FH5dont_atexit: function: herr_t; cdecl;
    FH5garbage_collect: function: herr_t; cdecl;
    FH5set_free_list_limits: function(reg_global_lim: Integer; reg_list_lim: Integer; arr_global_lim: Integer; arr_list_lim: Integer; blk_global_lim: Integer; blk_list_lim: Integer): herr_t; cdecl;
    FH5get_libversion: function(majnum: PCardinal; minnum: PCardinal; relnum: PCardinal): herr_t; cdecl;
    FH5check_version: function(majnum: Cardinal; minnum: Cardinal; relnum: Cardinal): herr_t; cdecl;
    FH5free_memory: function(mem: Pointer): herr_t; cdecl;
    FH5Iregister: function(typ: H5I_type_t; obj: Pointer): hid_t; cdecl;
    FH5Iobject_verify: function(id: hid_t; id_type: H5I_type_t): Pointer; cdecl;
    FH5Iremove_verify: function(id: hid_t; id_type: H5I_type_t): Pointer; cdecl;
    FH5Iget_type: function(id: hid_t): H5I_type_t; cdecl;
    FH5Iget_file_id: function(id: hid_t): hid_t; cdecl;
    FH5Iget_name: function(id: hid_t; name: PAnsiChar; size: size_t): ssize_t; cdecl;
    FH5Iinc_ref: function(id: hid_t): Integer; cdecl;
    FH5Idec_ref: function(id: hid_t): Integer; cdecl;
    FH5Iget_ref: function(id: hid_t): Integer; cdecl;
    FH5Iregister_type: function(hash_size: size_t; reserved: Cardinal; free_func: H5I_free_t): H5I_type_t; cdecl;
    FH5Iclear_type: function(typ: H5I_type_t; force: hbool_t): herr_t; cdecl;
    FH5Idestroy_type: function(typ: H5I_type_t): herr_t; cdecl;
    FH5Iinc_type_ref: function(typ: H5I_type_t): Integer; cdecl;
    FH5Idec_type_ref: function(typ: H5I_type_t): Integer; cdecl;
    FH5Iget_type_ref: function(typ: H5I_type_t): Integer; cdecl;
    FH5Isearch: function(typ: H5I_type_t; func: H5I_search_func_t; key: Pointer): Pointer; cdecl;
    FH5Inmembers: function(typ: H5I_type_t; num_members: Phsize_t): herr_t; cdecl;
    FH5Itype_exists: function(typ: H5I_type_t): htri_t; cdecl;
    FH5Iis_valid: function(id: hid_t): htri_t; cdecl;
    FH5Zregister: function(cls: Pointer): herr_t; cdecl;
    FH5Zunregister: function(id: H5Z_filter_t): herr_t; cdecl;
    FH5Zfilter_avail: function(id: H5Z_filter_t): htri_t; cdecl;
    FH5Zget_filter_info: function(filter: H5Z_filter_t; filter_config_flags: PCardinal): herr_t; cdecl;
    FH5Tcreate: function(typ: H5T_class_t; size: size_t): hid_t; cdecl;
    FH5Tcopy: function(type_id: hid_t): hid_t; cdecl;
    FH5Tclose: function(type_id: hid_t): herr_t; cdecl;
    FH5Tequal: function(type1_id: hid_t; type2_id: hid_t): htri_t; cdecl;
    FH5Tlock: function(type_id: hid_t): herr_t; cdecl;
    FH5Tcommit2: function(loc_id: hid_t; name: PAnsiChar; type_id: hid_t; lcpl_id: hid_t; tcpl_id: hid_t; tapl_id: hid_t): herr_t; cdecl;
    FH5Topen2: function(loc_id: hid_t; name: PAnsiChar; tapl_id: hid_t): hid_t; cdecl;
    FH5Tcommit_anon: function(loc_id: hid_t; type_id: hid_t; tcpl_id: hid_t; tapl_id: hid_t): herr_t; cdecl;
    FH5Tget_create_plist: function(type_id: hid_t): hid_t; cdecl;
    FH5Tcommitted: function(type_id: hid_t): htri_t; cdecl;
    FH5Tencode: function(obj_id: hid_t; buf: Pointer; nalloc: Psize_t): herr_t; cdecl;
    FH5Tdecode: function(buf: Pointer): hid_t; cdecl;
    FH5Tinsert: function(parent_id: hid_t; name: PAnsiChar; offset: size_t; member_id: hid_t): herr_t; cdecl;
    FH5Tpack: function(type_id: hid_t): herr_t; cdecl;
    FH5Tenum_create: function(base_id: hid_t): hid_t; cdecl;
    FH5Tenum_insert: function(typ: hid_t; name: PAnsiChar; value: Pointer): herr_t; cdecl;
    FH5Tenum_nameof: function(typ: hid_t; value: Pointer; name: PAnsiChar; size: size_t): herr_t; cdecl;
    FH5Tenum_valueof: function(typ: hid_t; name: PAnsiChar; value: Pointer): herr_t; cdecl;
    FH5Tvlen_create: function(base_id: hid_t): hid_t; cdecl;
    FH5Tarray_create2: function(base_id: hid_t; ndims: Cardinal; dim: Phsize_t): hid_t; cdecl;
    FH5Tget_array_ndims: function(type_id: hid_t): Integer; cdecl;
    FH5Tget_array_dims2: function(type_id: hid_t; dims: Phsize_t): Integer; cdecl;
    FH5Tset_tag: function(typ: hid_t; tag: PAnsiChar): herr_t; cdecl;
    FH5Tget_tag: function(typ: hid_t): PAnsiChar; cdecl;
    FH5Tget_super: function(typ: hid_t): hid_t; cdecl;
    FH5Tget_class: function(type_id: hid_t): H5T_class_t; cdecl;
    FH5Tdetect_class: function(type_id: hid_t; cls: H5T_class_t): htri_t; cdecl;
    FH5Tget_size: function(type_id: hid_t): size_t; cdecl;
    FH5Tget_order: function(type_id: hid_t): H5T_order_t; cdecl;
    FH5Tget_precision: function(type_id: hid_t): size_t; cdecl;
    FH5Tget_offset: function(type_id: hid_t): Integer; cdecl;
    FH5Tget_pad: function(type_id: hid_t; lsb: PH5T_pad_t; msb: PH5T_pad_t): herr_t; cdecl;
    FH5Tget_sign: function(type_id: hid_t): H5T_sign_t; cdecl;
    FH5Tget_fields: function(type_id: hid_t; spos: Psize_t; epos: Psize_t; esize: Psize_t; mpos: Psize_t; msize: Psize_t): herr_t; cdecl;
    FH5Tget_ebias: function(type_id: hid_t): size_t; cdecl;
    FH5Tget_norm: function(type_id: hid_t): H5T_norm_t; cdecl;
    FH5Tget_inpad: function(type_id: hid_t): H5T_pad_t; cdecl;
    FH5Tget_strpad: function(type_id: hid_t): H5T_str_t; cdecl;
    FH5Tget_nmembers: function(type_id: hid_t): Integer; cdecl;
    FH5Tget_member_name: function(type_id: hid_t; membno: Cardinal): PAnsiChar; cdecl;
    FH5Tget_member_index: function(type_id: hid_t; name: PAnsiChar): Integer; cdecl;
    FH5Tget_member_offset: function(type_id: hid_t; membno: Cardinal): size_t; cdecl;
    FH5Tget_member_class: function(type_id: hid_t; membno: Cardinal): H5T_class_t; cdecl;
    FH5Tget_member_type: function(type_id: hid_t; membno: Cardinal): hid_t; cdecl;
    FH5Tget_member_value: function(type_id: hid_t; membno: Cardinal; value: Pointer): herr_t; cdecl;
    FH5Tget_cset: function(type_id: hid_t): H5T_cset_t; cdecl;
    FH5Tis_variable_str: function(type_id: hid_t): htri_t; cdecl;
    FH5Tget_native_type: function(type_id: hid_t; direction: H5T_direction_t): hid_t; cdecl;
    FH5Tset_size: function(type_id: hid_t; size: size_t): herr_t; cdecl;
    FH5Tset_order: function(type_id: hid_t; order: H5T_order_t): herr_t; cdecl;
    FH5Tset_precision: function(type_id: hid_t; prec: size_t): herr_t; cdecl;
    FH5Tset_offset: function(type_id: hid_t; offset: size_t): herr_t; cdecl;
    FH5Tset_pad: function(type_id: hid_t; lsb: H5T_pad_t; msb: H5T_pad_t): herr_t; cdecl;
    FH5Tset_sign: function(type_id: hid_t; sign: H5T_sign_t): herr_t; cdecl;
    FH5Tset_fields: function(type_id: hid_t; spos: size_t; epos: size_t; esize: size_t; mpos: size_t; msize: size_t): herr_t; cdecl;
    FH5Tset_ebias: function(type_id: hid_t; ebias: size_t): herr_t; cdecl;
    FH5Tset_norm: function(type_id: hid_t; norm: H5T_norm_t): herr_t; cdecl;
    FH5Tset_inpad: function(type_id: hid_t; pad: H5T_pad_t): herr_t; cdecl;
    FH5Tset_cset: function(type_id: hid_t; cset: H5T_cset_t): herr_t; cdecl;
    FH5Tset_strpad: function(type_id: hid_t; strpad: H5T_str_t): herr_t; cdecl;
    FH5Tregister: function(pers: H5T_pers_t; name: PAnsiChar; src_id: hid_t; dst_id: hid_t; func: H5T_conv_t): herr_t; cdecl;
    FH5Tunregister: function(pers: H5T_pers_t; name: PAnsiChar; src_id: hid_t; dst_id: hid_t; func: H5T_conv_t): herr_t; cdecl;
    FH5Tfind: function(src_id: hid_t; dst_id: hid_t; pcdata: PPH5T_cdata_t): H5T_conv_t; cdecl;
    FH5Tcompiler_conv: function(src_id: hid_t; dst_id: hid_t): htri_t; cdecl;
    FH5Tconvert: function(src_id: hid_t; dst_id: hid_t; nelmts: size_t; buf: Pointer; background: Pointer; plist_id: hid_t): herr_t; cdecl;
    FH5Dcreate2: function(loc_id: hid_t; name: PAnsiChar; type_id: hid_t; space_id: hid_t; lcpl_id: hid_t; dcpl_id: hid_t; dapl_id: hid_t): hid_t; cdecl;
    FH5Dcreate_anon: function(file_id: hid_t; type_id: hid_t; space_id: hid_t; plist_id: hid_t; dapl_id: hid_t): hid_t; cdecl;
    FH5Dopen2: function(file_id: hid_t; name: PAnsiChar; dapl_id: hid_t): hid_t; cdecl;
    FH5Dclose: function(dset_id: hid_t): herr_t; cdecl;
    FH5Dget_space: function(dset_id: hid_t): hid_t; cdecl;
    FH5Dget_space_status: function(dset_id: hid_t; allocation: PH5D_space_status_t): herr_t; cdecl;
    FH5Dget_type: function(dset_id: hid_t): hid_t; cdecl;
    FH5Dget_create_plist: function(dset_id: hid_t): hid_t; cdecl;
    FH5Dget_access_plist: function(dset_id: hid_t): hid_t; cdecl;
    FH5Dget_storage_size: function(dset_id: hid_t): hsize_t; cdecl;
    FH5Dget_offset: function(dset_id: hid_t): haddr_t; cdecl;
    FH5Dread: function(dset_id: hid_t; mem_type_id: hid_t; mem_space_id: hid_t; file_space_id: hid_t; plist_id: hid_t; buf: Pointer): herr_t; cdecl;
    FH5Dwrite: function(dset_id: hid_t; mem_type_id: hid_t; mem_space_id: hid_t; file_space_id: hid_t; plist_id: hid_t; buf: Pointer): herr_t; cdecl;
    FH5Diterate: function(buf: Pointer; type_id: hid_t; space_id: hid_t; op: H5D_operator_t; operator_data: Pointer): herr_t; cdecl;
    FH5Dvlen_reclaim: function(type_id: hid_t; space_id: hid_t; plist_id: hid_t; buf: Pointer): herr_t; cdecl;
    FH5Dvlen_get_buf_size: function(dataset_id: hid_t; type_id: hid_t; space_id: hid_t; size: Phsize_t): herr_t; cdecl;
    FH5Dfill: function(fill: Pointer; fill_type: hid_t; buf: Pointer; buf_type: hid_t; space: hid_t): herr_t; cdecl;
    FH5Dset_extent: function(dset_id: hid_t; size: Phsize_t): herr_t; cdecl;
    FH5Dscatter: function(op: H5D_scatter_func_t; op_data: Pointer; type_id: hid_t; dst_space_id: hid_t; dst_buf: Pointer): herr_t; cdecl;
    FH5Dgather: function(src_space_id: hid_t; src_buf: Pointer; type_id: hid_t; dst_buf_size: size_t; dst_buf: Pointer; op: H5D_gather_func_t; op_data: Pointer): herr_t; cdecl;
    FH5Ddebug: function(dset_id: hid_t): herr_t; cdecl;
    FH5Eregister_class: function(cls_name: PAnsiChar; lib_name: PAnsiChar; version: PAnsiChar): hid_t; cdecl;
    FH5Eunregister_class: function(class_id: hid_t): herr_t; cdecl;
    FH5Eclose_msg: function(err_id: hid_t): herr_t; cdecl;
    FH5Ecreate_msg: function(cls: hid_t; msg_type: H5E_type_t; msg: PAnsiChar): hid_t; cdecl;
    FH5Ecreate_stack: function: hid_t; cdecl;
    FH5Eget_current_stack: function: hid_t; cdecl;
    FH5Eclose_stack: function(stack_id: hid_t): herr_t; cdecl;
    FH5Eget_class_name: function(class_id: hid_t; name: PAnsiChar; size: size_t): ssize_t; cdecl;
    FH5Eset_current_stack: function(err_stack_id: hid_t): herr_t; cdecl;
    // FH5Epush2: function(err_stack: hid_t; file_: PAnsiChar; func: PAnsiChar; line: Cardinal; cls_id: hid_t; maj_id: hid_t; min_id: hid_t; msg: PAnsiChar): herr_t; cdecl; varargs;
    FH5Epop: function(err_stack: hid_t; count: size_t): herr_t; cdecl;
    FH5Eprint2: function(err_stack: hid_t; stream: PFILE): herr_t; cdecl;
    FH5Ewalk2: function(err_stack: hid_t; direction: H5E_direction_t; func: H5E_walk2_t; client_data: Pointer): herr_t; cdecl;
    FH5Eget_auto2: function(estack_id: hid_t; func: PH5E_auto2_t; client_data: PPointer): herr_t; cdecl;
    FH5Eset_auto2: function(estack_id: hid_t; func: H5E_auto2_t; client_data: Pointer): herr_t; cdecl;
    FH5Eclear2: function(err_stack: hid_t): herr_t; cdecl;
    FH5Eauto_is_v2: function(err_stack: hid_t; is_stack: PCardinal): herr_t; cdecl;
    FH5Eget_msg: function(msg_id: hid_t; typ: PH5E_type_t; msg: PAnsiChar; size: size_t): ssize_t; cdecl;
    FH5Eget_num: function(error_stack_id: hid_t): ssize_t; cdecl;
    FH5Screate: function(typ: H5S_class_t): hid_t; cdecl;
    FH5Screate_simple: function(rank: Integer; dims: Phsize_t; maxdims: Phsize_t): hid_t; cdecl;
    FH5Sset_extent_simple: function(space_id: hid_t; rank: Integer; dims: Phsize_t; max: Phsize_t): herr_t; cdecl;
    FH5Scopy: function(space_id: hid_t): hid_t; cdecl;
    FH5Sclose: function(space_id: hid_t): herr_t; cdecl;
    FH5Sencode: function(obj_id: hid_t; buf: Pointer; nalloc: Psize_t): herr_t; cdecl;
    FH5Sdecode: function(buf: Pointer): hid_t; cdecl;
    FH5Sget_simple_extent_npoints: function(space_id: hid_t): hssize_t; cdecl;
    FH5Sget_simple_extent_ndims: function(space_id: hid_t): Integer; cdecl;
    FH5Sget_simple_extent_dims: function(space_id: hid_t; dims: Phsize_t; maxdims: Phsize_t): Integer; cdecl;
    FH5Sis_simple: function(space_id: hid_t): htri_t; cdecl;
    FH5Sget_select_npoints: function(spaceid: hid_t): hssize_t; cdecl;
    FH5Sselect_hyperslab: function(space_id: hid_t; op: H5S_seloper_t; start: Phsize_t; _stride: Phsize_t; count: Phsize_t; _block: Phsize_t): herr_t; cdecl;
    FH5Sselect_elements: function(space_id: hid_t; op: H5S_seloper_t; num_elem: size_t; coord: Phsize_t): herr_t; cdecl;
    FH5Sget_simple_extent_type: function(space_id: hid_t): H5S_class_t; cdecl;
    FH5Sset_extent_none: function(space_id: hid_t): herr_t; cdecl;
    FH5Sextent_copy: function(dst_id: hid_t; src_id: hid_t): herr_t; cdecl;
    FH5Sextent_equal: function(sid1: hid_t; sid2: hid_t): htri_t; cdecl;
    FH5Sselect_all: function(spaceid: hid_t): herr_t; cdecl;
    FH5Sselect_none: function(spaceid: hid_t): herr_t; cdecl;
    FH5Soffset_simple: function(space_id: hid_t; offset: Phssize_t): herr_t; cdecl;
    FH5Sselect_valid: function(spaceid: hid_t): htri_t; cdecl;
    FH5Sget_select_hyper_nblocks: function(spaceid: hid_t): hssize_t; cdecl;
    FH5Sget_select_elem_npoints: function(spaceid: hid_t): hssize_t; cdecl;
    FH5Sget_select_hyper_blocklist: function(spaceid: hid_t; startblock: hsize_t; numblocks: hsize_t; buf: Phsize_t): herr_t; cdecl;
    FH5Sget_select_elem_pointlist: function(spaceid: hid_t; startpoint: hsize_t; numpoints: hsize_t; buf: Phsize_t): herr_t; cdecl;
    FH5Sget_select_bounds: function(spaceid: hid_t; start: Phsize_t; end_: Phsize_t): herr_t; cdecl;
    FH5Sget_select_type: function(spaceid: hid_t): H5S_sel_type; cdecl;
    FH5Lmove: function(src_loc: hid_t; src_name: PAnsiChar; dst_loc: hid_t; dst_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Lcopy: function(src_loc: hid_t; src_name: PAnsiChar; dst_loc: hid_t; dst_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Lcreate_hard: function(cur_loc: hid_t; cur_name: PAnsiChar; dst_loc: hid_t; dst_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Lcreate_soft: function(link_target: PAnsiChar; link_loc_id: hid_t; link_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Ldelete: function(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): herr_t; cdecl;
    FH5Ldelete_by_idx: function(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Lget_val: function(loc_id: hid_t; name: PAnsiChar; buf: Pointer; size: size_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Lget_val_by_idx: function(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; buf: Pointer; size: size_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Lexists: function(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): htri_t; cdecl;
    FH5Lget_info: function(loc_id: hid_t; name: PAnsiChar; linfo: PH5L_info_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Lget_info_by_idx: function(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; linfo: PH5L_info_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Lget_name_by_idx: function(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; name: PAnsiChar; size: size_t; lapl_id: hid_t): ssize_t; cdecl;
    FH5Literate: function(grp_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5L_iterate_t; op_data: Pointer): herr_t; cdecl;
    FH5Literate_by_name: function(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5L_iterate_t; op_data: Pointer; lapl_id: hid_t): herr_t; cdecl;
    FH5Lvisit: function(grp_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; op: H5L_iterate_t; op_data: Pointer): herr_t; cdecl;
    FH5Lvisit_by_name: function(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; op: H5L_iterate_t; op_data: Pointer; lapl_id: hid_t): herr_t; cdecl;
    FH5Lcreate_ud: function(link_loc_id: hid_t; link_name: PAnsiChar; link_type: H5L_type_t; udata: Pointer; udata_size: size_t; lcpl_id: hid_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Lregister: function(cls: PH5L_class_t): herr_t; cdecl;
    FH5Lunregister: function(id: H5L_type_t): herr_t; cdecl;
    FH5Lis_registered: function(id: H5L_type_t): htri_t; cdecl;
    FH5Lunpack_elink_val: function(ext_linkval: Pointer; link_size: size_t; flags: PCardinal; filename: PPAnsiChar; obj_path: PPAnsiChar): herr_t; cdecl;
    FH5Lcreate_external: function(file_name: PAnsiChar; obj_name: PAnsiChar; link_loc_id: hid_t; link_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Oopen: function(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): hid_t; cdecl;
    FH5Oopen_by_addr: function(loc_id: hid_t; addr: haddr_t): hid_t; cdecl;
    FH5Oopen_by_idx: function(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; lapl_id: hid_t): hid_t; cdecl;
    FH5Oexists_by_name: function(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): htri_t; cdecl;
    FH5Oget_info: function(loc_id: hid_t; oinfo: PH5O_info_t): herr_t; cdecl;
    FH5Oget_info_by_name: function(loc_id: hid_t; name: PAnsiChar; oinfo: PH5O_info_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Oget_info_by_idx: function(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; oinfo: PH5O_info_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Olink: function(obj_id: hid_t; new_loc_id: hid_t; new_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Oincr_refcount: function(object_id: hid_t): herr_t; cdecl;
    FH5Odecr_refcount: function(object_id: hid_t): herr_t; cdecl;
    FH5Ocopy: function(src_loc_id: hid_t; src_name: PAnsiChar; dst_loc_id: hid_t; dst_name: PAnsiChar; ocpypl_id: hid_t; lcpl_id: hid_t): herr_t; cdecl;
    FH5Oset_comment: function(obj_id: hid_t; comment: PAnsiChar): herr_t; cdecl;
    FH5Oset_comment_by_name: function(loc_id: hid_t; name: PAnsiChar; comment: PAnsiChar; lapl_id: hid_t): herr_t; cdecl;
    FH5Oget_comment: function(obj_id: hid_t; comment: PAnsiChar; bufsize: size_t): ssize_t; cdecl;
    FH5Oget_comment_by_name: function(loc_id: hid_t; name: PAnsiChar; comment: PAnsiChar; bufsize: size_t; lapl_id: hid_t): ssize_t; cdecl;
    FH5Ovisit: function(obj_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; op: H5O_iterate_t; op_data: Pointer): herr_t; cdecl;
    FH5Ovisit_by_name: function(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; op: H5O_iterate_t; op_data: Pointer; lapl_id: hid_t): herr_t; cdecl;
    FH5Oclose: function(object_id: hid_t): herr_t; cdecl;
    FH5Fis_hdf5: function(filename: PAnsiChar): htri_t; cdecl;
    FH5Fcreate: function(filename: PAnsiChar; flags: Cardinal; create_plist: hid_t; access_plist: hid_t): hid_t; cdecl;
    FH5Fopen: function(filename: PAnsiChar; flags: Cardinal; access_plist: hid_t): hid_t; cdecl;
    FH5Freopen: function(file_id: hid_t): hid_t; cdecl;
    FH5Fflush: function(object_id: hid_t; scope: H5F_scope_t): herr_t; cdecl;
    FH5Fclose: function(file_id: hid_t): herr_t; cdecl;
    FH5Fget_create_plist: function(file_id: hid_t): hid_t; cdecl;
    FH5Fget_access_plist: function(file_id: hid_t): hid_t; cdecl;
    FH5Fget_intent: function(file_id: hid_t; intent: PCardinal): herr_t; cdecl;
    FH5Fget_obj_count: function(file_id: hid_t; types: Cardinal): ssize_t; cdecl;
    FH5Fget_obj_ids: function(file_id: hid_t; types: Cardinal; max_objs: size_t; obj_id_list: Phid_t): ssize_t; cdecl;
    FH5Fget_vfd_handle: function(file_id: hid_t; fapl: hid_t; file_handle: PPointer): herr_t; cdecl;
    FH5Fmount: function(loc: hid_t; name: PAnsiChar; child: hid_t; plist: hid_t): herr_t; cdecl;
    FH5Funmount: function(loc: hid_t; name: PAnsiChar): herr_t; cdecl;
    FH5Fget_freespace: function(file_id: hid_t): hssize_t; cdecl;
    FH5Fget_filesize: function(file_id: hid_t; size: Phsize_t): herr_t; cdecl;
    FH5Fget_file_image: function(file_id: hid_t; buf_ptr: Pointer; buf_len: size_t): ssize_t; cdecl;
    FH5Fget_mdc_config: function(file_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t; cdecl;
    FH5Fset_mdc_config: function(file_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t; cdecl;
    FH5Fget_mdc_hit_rate: function(file_id: hid_t; hit_rate_ptr: Pdouble): herr_t; cdecl;
    FH5Fget_mdc_size: function(file_id: hid_t; max_size_ptr: Psize_t; min_clean_size_ptr: Psize_t; cur_size_ptr: Psize_t; cur_num_entries_ptr: PInteger): herr_t; cdecl;
    FH5Freset_mdc_hit_rate_stats: function(file_id: hid_t): herr_t; cdecl;
    FH5Fget_name: function(obj_id: hid_t; name: PAnsiChar; size: size_t): ssize_t; cdecl;
    FH5Fget_info: function(obj_id: hid_t; bh_info: PH5F_info_t): herr_t; cdecl;
    FH5Fclear_elink_file_cache: function(file_id: hid_t): herr_t; cdecl;
    FH5Acreate2: function(loc_id: hid_t; attr_name: PAnsiChar; type_id: hid_t; space_id: hid_t; acpl_id: hid_t; aapl_id: hid_t): hid_t; cdecl;
    FH5Acreate_by_name: function(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; type_id: hid_t; space_id: hid_t; acpl_id: hid_t; aapl_id: hid_t; lapl_id: hid_t): hid_t; cdecl;
    FH5Aopen: function(obj_id: hid_t; attr_name: PAnsiChar; aapl_id: hid_t): hid_t; cdecl;
    FH5Aopen_by_name: function(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; aapl_id: hid_t; lapl_id: hid_t): hid_t; cdecl;
    FH5Aopen_by_idx: function(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; aapl_id: hid_t; lapl_id: hid_t): hid_t; cdecl;
    FH5Awrite: function(attr_id: hid_t; type_id: hid_t; buf: Pointer): herr_t; cdecl;
    FH5Aread: function(attr_id: hid_t; type_id: hid_t; buf: Pointer): herr_t; cdecl;
    FH5Aclose: function(attr_id: hid_t): herr_t; cdecl;
    FH5Aget_space: function(attr_id: hid_t): hid_t; cdecl;
    FH5Aget_type: function(attr_id: hid_t): hid_t; cdecl;
    FH5Aget_create_plist: function(attr_id: hid_t): hid_t; cdecl;
    FH5Aget_name: function(attr_id: hid_t; buf_size: size_t; buf: PAnsiChar): ssize_t; cdecl;
    FH5Aget_name_by_idx: function(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; name: PAnsiChar; size: size_t; lapl_id: hid_t): ssize_t; cdecl;
    FH5Aget_storage_size: function(attr_id: hid_t): hsize_t; cdecl;
    FH5Aget_info: function(attr_id: hid_t; ainfo: PH5A_info_t): herr_t; cdecl;
    FH5Aget_info_by_name: function(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; ainfo: PH5A_info_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Aget_info_by_idx: function(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; ainfo: PH5A_info_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Arename: function(loc_id: hid_t; old_name: PAnsiChar; new_name: PAnsiChar): herr_t; cdecl;
    FH5Arename_by_name: function(loc_id: hid_t; obj_name: PAnsiChar; old_attr_name: PAnsiChar; new_attr_name: PAnsiChar; lapl_id: hid_t): herr_t; cdecl;
    FH5Aiterate2: function(loc_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5A_operator2_t; op_data: Pointer): herr_t; cdecl;
    FH5Aiterate_by_name: function(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5A_operator2_t; op_data: Pointer; lapd_id: hid_t): herr_t; cdecl;
    FH5Adelete: function(loc_id: hid_t; name: PAnsiChar): herr_t; cdecl;
    FH5Adelete_by_name: function(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; lapl_id: hid_t): herr_t; cdecl;
    FH5Adelete_by_idx: function(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Aexists: function(obj_id: hid_t; attr_name: PAnsiChar): htri_t; cdecl;
    FH5Aexists_by_name: function(obj_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; lapl_id: hid_t): htri_t; cdecl;
    FH5FDregister: function(cls: PH5FD_class_t): hid_t; cdecl;
    FH5FDunregister: function(driver_id: hid_t): herr_t; cdecl;
    FH5FDopen: function(name: PAnsiChar; flags: Cardinal; fapl_id: hid_t; maxaddr: haddr_t): PH5FD_t; cdecl;
    FH5FDclose: function(file_: PH5FD_t): herr_t; cdecl;
    FH5FDcmp: function(f1: PH5FD_t; f2: PH5FD_t): Integer; cdecl;
    FH5FDquery: function(f: PH5FD_t; flags: PCardinal): Integer; cdecl;
    FH5FDalloc: function(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; size: hsize_t): haddr_t; cdecl;
    FH5FDfree: function(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; addr: haddr_t; size: hsize_t): herr_t; cdecl;
    FH5FDget_eoa: function(file_: PH5FD_t; typ: H5FD_mem_t): haddr_t; cdecl;
    FH5FDset_eoa: function(file_: PH5FD_t; typ: H5FD_mem_t; eoa: haddr_t): herr_t; cdecl;
    FH5FDget_eof: function(file_: PH5FD_t): haddr_t; cdecl;
    FH5FDget_vfd_handle: function(file_: PH5FD_t; fapl: hid_t; file_handle: PPointer): herr_t; cdecl;
    FH5FDread: function(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; addr: haddr_t; size: size_t; buf: Pointer): herr_t; cdecl;
    FH5FDwrite: function(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; addr: haddr_t; size: size_t; buf: Pointer): herr_t; cdecl;
    FH5FDflush: function(file_: PH5FD_t; dxpl_id: hid_t; closing: Cardinal): herr_t; cdecl;
    FH5FDtruncate: function(file_: PH5FD_t; dxpl_id: hid_t; closing: hbool_t): herr_t; cdecl;
    FH5Gcreate2: function(loc_id: hid_t; name: PAnsiChar; lcpl_id: hid_t; gcpl_id: hid_t; gapl_id: hid_t): hid_t; cdecl;
    FH5Gcreate_anon: function(loc_id: hid_t; gcpl_id: hid_t; gapl_id: hid_t): hid_t; cdecl;
    FH5Gopen2: function(loc_id: hid_t; name: PAnsiChar; gapl_id: hid_t): hid_t; cdecl;
    FH5Gget_create_plist: function(group_id: hid_t): hid_t; cdecl;
    FH5Gget_info: function(loc_id: hid_t; ginfo: PH5G_info_t): herr_t; cdecl;
    FH5Gget_info_by_name: function(loc_id: hid_t; name: PAnsiChar; ginfo: PH5G_info_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Gget_info_by_idx: function(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; ginfo: PH5G_info_t; lapl_id: hid_t): herr_t; cdecl;
    FH5Gclose: function(group_id: hid_t): herr_t; cdecl;
    FH5Rcreate: function(ref: Pointer; loc_id: hid_t; name: PAnsiChar; ref_type: H5R_type_t; space_id: hid_t): herr_t; cdecl;
    FH5Rdereference: function(dataset: hid_t; ref_type: H5R_type_t; ref: Pointer): hid_t; cdecl;
    FH5Rget_region: function(dataset: hid_t; ref_type: H5R_type_t; ref: Pointer): hid_t; cdecl;
    FH5Rget_obj_type2: function(id: hid_t; ref_type: H5R_type_t; _ref: Pointer; obj_type: PH5O_type_t): herr_t; cdecl;
    FH5Rget_name: function(loc_id: hid_t; ref_type: H5R_type_t; ref: Pointer; name: PAnsiChar; size: size_t): ssize_t; cdecl;
    FH5Pcreate_class: function(parent: hid_t; name: PAnsiChar; cls_create: H5P_cls_create_func_t; create_data: Pointer; cls_copy: H5P_cls_copy_func_t; copy_data: Pointer; cls_close: H5P_cls_close_func_t; close_data: Pointer): hid_t; cdecl;
    FH5Pget_class_name: function(pclass_id: hid_t): PAnsiChar; cdecl;
    FH5Pcreate: function(cls_id: hid_t): hid_t; cdecl;
    FH5Pregister2: function(cls_id: hid_t; name: PAnsiChar; size: size_t; def_value: Pointer; prp_create: H5P_prp_create_func_t; prp_set: H5P_prp_set_func_t; prp_get: H5P_prp_get_func_t; prp_del: H5P_prp_delete_func_t; prp_copy: H5P_prp_copy_func_t; prp_cmp: H5P_prp_compare_func_t; prp_close: H5P_prp_close_func_t): herr_t; cdecl;
    FH5Pinsert2: function(plist_id: hid_t; name: PAnsiChar; size: size_t; value: Pointer; prp_set: H5P_prp_set_func_t; prp_get: H5P_prp_get_func_t; prp_delete: H5P_prp_delete_func_t; prp_copy: H5P_prp_copy_func_t; prp_cmp: H5P_prp_compare_func_t; prp_close: H5P_prp_close_func_t): herr_t; cdecl;
    FH5Pset: function(plist_id: hid_t; name: PAnsiChar; value: Pointer): herr_t; cdecl;
    FH5Pexist: function(plist_id: hid_t; name: PAnsiChar): htri_t; cdecl;
    FH5Pget_size: function(id: hid_t; name: PAnsiChar; size: Psize_t): herr_t; cdecl;
    FH5Pget_nprops: function(id: hid_t; nprops: Psize_t): herr_t; cdecl;
    FH5Pget_class: function(plist_id: hid_t): hid_t; cdecl;
    FH5Pget_class_parent: function(pclass_id: hid_t): hid_t; cdecl;
    FH5Pget: function(plist_id: hid_t; name: PAnsiChar; value: Pointer): herr_t; cdecl;
    FH5Pequal: function(id1: hid_t; id2: hid_t): htri_t; cdecl;
    FH5Pisa_class: function(plist_id: hid_t; pclass_id: hid_t): htri_t; cdecl;
    FH5Piterate: function(id: hid_t; idx: PInteger; iter_func: H5P_iterate_t; iter_data: Pointer): Integer; cdecl;
    FH5Pcopy_prop: function(dst_id: hid_t; src_id: hid_t; name: PAnsiChar): herr_t; cdecl;
    FH5Premove: function(plist_id: hid_t; name: PAnsiChar): herr_t; cdecl;
    FH5Punregister: function(pclass_id: hid_t; name: PAnsiChar): herr_t; cdecl;
    FH5Pclose_class: function(plist_id: hid_t): herr_t; cdecl;
    FH5Pclose: function(plist_id: hid_t): herr_t; cdecl;
    FH5Pcopy: function(plist_id: hid_t): hid_t; cdecl;
    FH5Pset_attr_phase_change: function(plist_id: hid_t; max_compact: Cardinal; min_dense: Cardinal): herr_t; cdecl;
    FH5Pget_attr_phase_change: function(plist_id: hid_t; max_compact: PCardinal; min_dense: PCardinal): herr_t; cdecl;
    FH5Pset_attr_creation_order: function(plist_id: hid_t; crt_order_flags: Cardinal): herr_t; cdecl;
    FH5Pget_attr_creation_order: function(plist_id: hid_t; crt_order_flags: PCardinal): herr_t; cdecl;
    FH5Pset_obj_track_times: function(plist_id: hid_t; track_times: hbool_t): herr_t; cdecl;
    FH5Pget_obj_track_times: function(plist_id: hid_t; track_times: Phbool_t): herr_t; cdecl;
    FH5Pmodify_filter: function(plist_id: hid_t; filter: H5Z_filter_t; flags: Cardinal; cd_nelmts: size_t; cd_values: PCardinal): herr_t; cdecl;
    FH5Pset_filter: function(plist_id: hid_t; filter: H5Z_filter_t; flags: Cardinal; cd_nelmts: size_t; c_values: PCardinal): herr_t; cdecl;
    FH5Pget_nfilters: function(plist_id: hid_t): Integer; cdecl;
    FH5Pget_filter2: function(plist_id: hid_t; filter: Cardinal; flags: PCardinal; cd_nelmts: Psize_t; cd_values: PCardinal; namelen: size_t; name: PAnsiChar; filter_config: PCardinal): H5Z_filter_t; cdecl;
    FH5Pget_filter_by_id2: function(plist_id: hid_t; id: H5Z_filter_t; flags: PCardinal; cd_nelmts: Psize_t; cd_values: PCardinal; namelen: size_t; name: PAnsiChar; filter_config: PCardinal): herr_t; cdecl;
    FH5Pall_filters_avail: function(plist_id: hid_t): htri_t; cdecl;
    FH5Premove_filter: function(plist_id: hid_t; filter: H5Z_filter_t): herr_t; cdecl;
    FH5Pset_deflate: function(plist_id: hid_t; aggression: Cardinal): herr_t; cdecl;
    FH5Pset_fletcher32: function(plist_id: hid_t): herr_t; cdecl;
    FH5Pget_version: function(plist_id: hid_t; boot: PCardinal; freelist: PCardinal; stab: PCardinal; shhdr: PCardinal): herr_t; cdecl;
    FH5Pset_userblock: function(plist_id: hid_t; size: hsize_t): herr_t; cdecl;
    FH5Pget_userblock: function(plist_id: hid_t; size: Phsize_t): herr_t; cdecl;
    FH5Pset_sizes: function(plist_id: hid_t; sizeof_addr: size_t; sizeof_size: size_t): herr_t; cdecl;
    FH5Pget_sizes: function(plist_id: hid_t; sizeof_addr: Psize_t; sizeof_size: Psize_t): herr_t; cdecl;
    FH5Pset_sym_k: function(plist_id: hid_t; ik: Cardinal; lk: Cardinal): herr_t; cdecl;
    FH5Pget_sym_k: function(plist_id: hid_t; ik: PCardinal; lk: PCardinal): herr_t; cdecl;
    FH5Pset_istore_k: function(plist_id: hid_t; ik: Cardinal): herr_t; cdecl;
    FH5Pget_istore_k: function(plist_id: hid_t; ik: PCardinal): herr_t; cdecl;
    FH5Pset_shared_mesg_nindexes: function(plist_id: hid_t; nindexes: Cardinal): herr_t; cdecl;
    FH5Pget_shared_mesg_nindexes: function(plist_id: hid_t; nindexes: PCardinal): herr_t; cdecl;
    FH5Pset_shared_mesg_index: function(plist_id: hid_t; index_num: Cardinal; mesg_type_flags: Cardinal; min_mesg_size: Cardinal): herr_t; cdecl;
    FH5Pget_shared_mesg_index: function(plist_id: hid_t; index_num: Cardinal; mesg_type_flags: PCardinal; min_mesg_size: PCardinal): herr_t; cdecl;
    FH5Pset_shared_mesg_phase_change: function(plist_id: hid_t; max_list: Cardinal; min_btree: Cardinal): herr_t; cdecl;
    FH5Pget_shared_mesg_phase_change: function(plist_id: hid_t; max_list: PCardinal; min_btree: PCardinal): herr_t; cdecl;
    FH5Pset_alignment: function(fapl_id: hid_t; threshold: hsize_t; alignment: hsize_t): herr_t; cdecl;
    FH5Pget_alignment: function(fapl_id: hid_t; threshold: Phsize_t; alignment: Phsize_t): herr_t; cdecl;
    FH5Pset_driver: function(plist_id: hid_t; driver_id: hid_t; driver_info: Pointer): herr_t; cdecl;
    FH5Pget_driver: function(plist_id: hid_t): hid_t; cdecl;
    FH5Pget_driver_info: function(plist_id: hid_t): Pointer; cdecl;
    FH5Pset_family_offset: function(fapl_id: hid_t; offset: hsize_t): herr_t; cdecl;
    FH5Pget_family_offset: function(fapl_id: hid_t; offset: Phsize_t): herr_t; cdecl;
    FH5Pset_multi_type: function(fapl_id: hid_t; typ: H5FD_mem_t): herr_t; cdecl;
    FH5Pget_multi_type: function(fapl_id: hid_t; typ: PH5FD_mem_t): herr_t; cdecl;
    FH5Pset_cache: function(plist_id: hid_t; mdc_nelmts: Integer; rdcc_nslots: size_t; rdcc_nbytes: size_t; rdcc_w0: double): herr_t; cdecl;
    FH5Pget_cache: function(plist_id: hid_t; mdc_nelmts: PInteger; rdcc_nslots: Psize_t; rdcc_nbytes: Psize_t; rdcc_w0: Pdouble): herr_t; cdecl;
    FH5Pset_mdc_config: function(plist_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t; cdecl;
    FH5Pget_mdc_config: function(plist_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t; cdecl;
    FH5Pset_gc_references: function(fapl_id: hid_t; gc_ref: Cardinal): herr_t; cdecl;
    FH5Pget_gc_references: function(fapl_id: hid_t; gc_ref: PCardinal): herr_t; cdecl;
    FH5Pset_fclose_degree: function(fapl_id: hid_t; degree: H5F_close_degree_t): herr_t; cdecl;
    FH5Pget_fclose_degree: function(fapl_id: hid_t; degree: PH5F_close_degree_t): herr_t; cdecl;
    FH5Pset_meta_block_size: function(fapl_id: hid_t; size: hsize_t): herr_t; cdecl;
    FH5Pget_meta_block_size: function(fapl_id: hid_t; size: Phsize_t): herr_t; cdecl;
    FH5Pset_sieve_buf_size: function(fapl_id: hid_t; size: size_t): herr_t; cdecl;
    FH5Pget_sieve_buf_size: function(fapl_id: hid_t; size: Psize_t): herr_t; cdecl;
    FH5Pset_small_data_block_size: function(fapl_id: hid_t; size: hsize_t): herr_t; cdecl;
    FH5Pget_small_data_block_size: function(fapl_id: hid_t; size: Phsize_t): herr_t; cdecl;
    FH5Pset_libver_bounds: function(plist_id: hid_t; low: H5F_libver_t; high: H5F_libver_t): herr_t; cdecl;
    FH5Pget_libver_bounds: function(plist_id: hid_t; low: PH5F_libver_t; high: PH5F_libver_t): herr_t; cdecl;
    FH5Pset_elink_file_cache_size: function(plist_id: hid_t; efc_size: Cardinal): herr_t; cdecl;
    FH5Pget_elink_file_cache_size: function(plist_id: hid_t; efc_size: PCardinal): herr_t; cdecl;
    FH5Pset_file_image: function(fapl_id: hid_t; buf_ptr: Pointer; buf_len: size_t): herr_t; cdecl;
    FH5Pget_file_image: function(fapl_id: hid_t; buf_ptr_ptr: PPointer; buf_len_ptr: Psize_t): herr_t; cdecl;
    FH5Pset_file_image_callbacks: function(fapl_id: hid_t; callbacks_ptr: PH5FD_file_image_callbacks_t): herr_t; cdecl;
    FH5Pget_file_image_callbacks: function(fapl_id: hid_t; callbacks_ptr: PH5FD_file_image_callbacks_t): herr_t; cdecl;
    FH5Pset_core_write_tracking: function(fapl_id: hid_t; is_enabled: hbool_t; page_size: size_t): herr_t; cdecl;
    FH5Pget_core_write_tracking: function(fapl_id: hid_t; is_enabled: Phbool_t; page_size: Psize_t): herr_t; cdecl;
    FH5Pset_layout: function(plist_id: hid_t; layout: H5D_layout_t): herr_t; cdecl;
    FH5Pget_layout: function(plist_id: hid_t): H5D_layout_t; cdecl;
    FH5Pset_chunk: function(plist_id: hid_t; ndims: Integer; dim: Phsize_t): herr_t; cdecl;
    FH5Pget_chunk: function(plist_id: hid_t; max_ndims: Integer; dim: Phsize_t): Integer; cdecl;
    FH5Pset_external: function(plist_id: hid_t; name: PAnsiChar; offset: off_t; size: hsize_t): herr_t; cdecl;
    FH5Pget_external_count: function(plist_id: hid_t): Integer; cdecl;
    FH5Pget_external: function(plist_id: hid_t; idx: Cardinal; name_size: size_t; name: PAnsiChar; offset: Poff_t; size: Phsize_t): herr_t; cdecl;
    FH5Pset_szip: function(plist_id: hid_t; options_mask: Cardinal; pixels_per_block: Cardinal): herr_t; cdecl;
    FH5Pset_shuffle: function(plist_id: hid_t): herr_t; cdecl;
    FH5Pset_nbit: function(plist_id: hid_t): herr_t; cdecl;
    FH5Pset_scaleoffset: function(plist_id: hid_t; scale_type: H5Z_SO_scale_type_t; scale_factor: Integer): herr_t; cdecl;
    FH5Pset_fill_value: function(plist_id: hid_t; type_id: hid_t; value: Pointer): herr_t; cdecl;
    FH5Pget_fill_value: function(plist_id: hid_t; type_id: hid_t; value: Pointer): herr_t; cdecl;
    FH5Pfill_value_defined: function(plist: hid_t; status: PH5D_fill_value_t): herr_t; cdecl;
    FH5Pset_alloc_time: function(plist_id: hid_t; alloc_time: H5D_alloc_time_t): herr_t; cdecl;
    FH5Pget_alloc_time: function(plist_id: hid_t; alloc_time: PH5D_alloc_time_t): herr_t; cdecl;
    FH5Pset_fill_time: function(plist_id: hid_t; fill_time: H5D_fill_time_t): herr_t; cdecl;
    FH5Pget_fill_time: function(plist_id: hid_t; fill_time: PH5D_fill_time_t): herr_t; cdecl;
    FH5Pset_chunk_cache: function(dapl_id: hid_t; rdcc_nslots: size_t; rdcc_nbytes: size_t; rdcc_w0: double): herr_t; cdecl;
    FH5Pget_chunk_cache: function(dapl_id: hid_t; rdcc_nslots: Psize_t; rdcc_nbytes: Psize_t; rdcc_w0: Pdouble): herr_t; cdecl;
    FH5Pset_data_transform: function(plist_id: hid_t; expression: PAnsiChar): herr_t; cdecl;
    FH5Pget_data_transform: function(plist_id: hid_t; expression: PAnsiChar; size: size_t): ssize_t; cdecl;
    FH5Pset_buffer: function(plist_id: hid_t; size: size_t; tconv: Pointer; bkg: Pointer): herr_t; cdecl;
    FH5Pget_buffer: function(plist_id: hid_t; tconv: PPointer; bkg: PPointer): size_t; cdecl;
    FH5Pset_preserve: function(plist_id: hid_t; status: hbool_t): herr_t; cdecl;
    FH5Pget_preserve: function(plist_id: hid_t): Integer; cdecl;
    FH5Pset_edc_check: function(plist_id: hid_t; check: H5Z_EDC_t): herr_t; cdecl;
    FH5Pget_edc_check: function(plist_id: hid_t): H5Z_EDC_t; cdecl;
    FH5Pset_filter_callback: function(plist_id: hid_t; func: H5Z_filter_func_t; op_data: Pointer): herr_t; cdecl;
    FH5Pset_btree_ratios: function(plist_id: hid_t; left: double; middle: double; right: double): herr_t; cdecl;
    FH5Pget_btree_ratios: function(plist_id: hid_t; left: Pdouble; middle: Pdouble; right: Pdouble): herr_t; cdecl;
    FH5Pset_vlen_mem_manager: function(plist_id: hid_t; alloc_func: H5MM_allocate_t; alloc_info: Pointer; free_func: H5MM_free_t; free_info: Pointer): herr_t; cdecl;
    FH5Pget_vlen_mem_manager: function(plist_id: hid_t; alloc_func: PH5MM_allocate_t; alloc_info: PPointer; free_func: PH5MM_free_t; free_info: PPointer): herr_t; cdecl;
    FH5Pset_hyper_vector_size: function(fapl_id: hid_t; size: size_t): herr_t; cdecl;
    FH5Pget_hyper_vector_size: function(fapl_id: hid_t; size: Psize_t): herr_t; cdecl;
    FH5Pset_type_conv_cb: function(dxpl_id: hid_t; op: H5T_conv_except_func_t; operate_data: Pointer): herr_t; cdecl;
    FH5Pget_type_conv_cb: function(dxpl_id: hid_t; op: PH5T_conv_except_func_t; operate_data: PPointer): herr_t; cdecl;
    FH5Pset_create_intermediate_group: function(plist_id: hid_t; crt_intmd: Cardinal): herr_t; cdecl;
    FH5Pget_create_intermediate_group: function(plist_id: hid_t; crt_intmd: PCardinal): herr_t; cdecl;
    FH5Pset_local_heap_size_hint: function(plist_id: hid_t; size_hint: size_t): herr_t; cdecl;
    FH5Pget_local_heap_size_hint: function(plist_id: hid_t; size_hint: Psize_t): herr_t; cdecl;
    FH5Pset_link_phase_change: function(plist_id: hid_t; max_compact: Cardinal; min_dense: Cardinal): herr_t; cdecl;
    FH5Pget_link_phase_change: function(plist_id: hid_t; max_compact: PCardinal; min_dense: PCardinal): herr_t; cdecl;
    FH5Pset_est_link_info: function(plist_id: hid_t; est_num_entries: Cardinal; est_name_len: Cardinal): herr_t; cdecl;
    FH5Pget_est_link_info: function(plist_id: hid_t; est_num_entries: PCardinal; est_name_len: PCardinal): herr_t; cdecl;
    FH5Pset_link_creation_order: function(plist_id: hid_t; crt_order_flags: Cardinal): herr_t; cdecl;
    FH5Pget_link_creation_order: function(plist_id: hid_t; crt_order_flags: PCardinal): herr_t; cdecl;
    FH5Pset_char_encoding: function(plist_id: hid_t; encoding: H5T_cset_t): herr_t; cdecl;
    FH5Pget_char_encoding: function(plist_id: hid_t; encoding: PH5T_cset_t): herr_t; cdecl;
    FH5Pset_nlinks: function(plist_id: hid_t; nlinks: size_t): herr_t; cdecl;
    FH5Pget_nlinks: function(plist_id: hid_t; nlinks: Psize_t): herr_t; cdecl;
    FH5Pset_elink_prefix: function(plist_id: hid_t; prefix: PAnsiChar): herr_t; cdecl;
    FH5Pget_elink_prefix: function(plist_id: hid_t; prefix: PAnsiChar; size: size_t): ssize_t; cdecl;
    FH5Pget_elink_fapl: function(lapl_id: hid_t): hid_t; cdecl;
    FH5Pset_elink_fapl: function(lapl_id: hid_t; fapl_id: hid_t): herr_t; cdecl;
    FH5Pset_elink_acc_flags: function(lapl_id: hid_t; flags: Cardinal): herr_t; cdecl;
    FH5Pget_elink_acc_flags: function(lapl_id: hid_t; flags: PCardinal): herr_t; cdecl;
    FH5Pset_elink_cb: function(lapl_id: hid_t; func: H5L_elink_traverse_t; op_data: Pointer): herr_t; cdecl;
    FH5Pget_elink_cb: function(lapl_id: hid_t; func: PH5L_elink_traverse_t; op_data: PPointer): herr_t; cdecl;
    FH5Pset_copy_object: function(plist_id: hid_t; crt_intmd: Cardinal): herr_t; cdecl;
    FH5Pget_copy_object: function(plist_id: hid_t; crt_intmd: PCardinal): herr_t; cdecl;
    FH5Padd_merge_committed_dtype_path: function(plist_id: hid_t; path: PAnsiChar): herr_t; cdecl;
    FH5Pfree_merge_committed_dtype_paths: function(plist_id: hid_t): herr_t; cdecl;
    FH5Pset_mcdt_search_cb: function(plist_id: hid_t; func: H5O_mcdt_search_cb_t; op_data: Pointer): herr_t; cdecl;
    FH5Pget_mcdt_search_cb: function(plist_id: hid_t; func: PH5O_mcdt_search_cb_t; op_data: PPointer): herr_t; cdecl;
    FH5T_IEEE_F32BE: hid_t;
    FH5T_IEEE_F32LE: hid_t;
    FH5T_IEEE_F64BE: hid_t;
    FH5T_IEEE_F64LE: hid_t;
    FH5T_STD_I8BE: hid_t;
    FH5T_STD_I8LE: hid_t;
    FH5T_STD_I16BE: hid_t;
    FH5T_STD_I16LE: hid_t;
    FH5T_STD_I32BE: hid_t;
    FH5T_STD_I32LE: hid_t;
    FH5T_STD_I64BE: hid_t;
    FH5T_STD_I64LE: hid_t;
    FH5T_STD_U8BE: hid_t;
    FH5T_STD_U8LE: hid_t;
    FH5T_STD_U16BE: hid_t;
    FH5T_STD_U16LE: hid_t;
    FH5T_STD_U32BE: hid_t;
    FH5T_STD_U32LE: hid_t;
    FH5T_STD_U64BE: hid_t;
    FH5T_STD_U64LE: hid_t;
    FH5T_STD_B8BE: hid_t;
    FH5T_STD_B8LE: hid_t;
    FH5T_STD_B16BE: hid_t;
    FH5T_STD_B16LE: hid_t;
    FH5T_STD_B32BE: hid_t;
    FH5T_STD_B32LE: hid_t;
    FH5T_STD_B64BE: hid_t;
    FH5T_STD_B64LE: hid_t;
    FH5T_STD_REF_OBJ: hid_t;
    FH5T_STD_REF_DSETREG: hid_t;
    FH5T_UNIX_D32BE: hid_t;
    FH5T_UNIX_D32LE: hid_t;
    FH5T_UNIX_D64BE: hid_t;
    FH5T_UNIX_D64LE: hid_t;
    FH5T_C_S1: hid_t;
    FH5T_FORTRAN_S1: hid_t;
    FH5T_VAX_F32: hid_t;
    FH5T_VAX_F64: hid_t;
    FH5T_NATIVE_SCHAR: hid_t;
    FH5T_NATIVE_UCHAR: hid_t;
    FH5T_NATIVE_SHORT: hid_t;
    FH5T_NATIVE_USHORT: hid_t;
    FH5T_NATIVE_INT: hid_t;
    FH5T_NATIVE_UINT: hid_t;
    FH5T_NATIVE_LONG: hid_t;
    FH5T_NATIVE_ULONG: hid_t;
    FH5T_NATIVE_LLONG: hid_t;
    FH5T_NATIVE_ULLONG: hid_t;
    FH5T_NATIVE_FLOAT: hid_t;
    FH5T_NATIVE_DOUBLE: hid_t;
    FH5T_NATIVE_B8: hid_t;
    FH5T_NATIVE_B16: hid_t;
    FH5T_NATIVE_B32: hid_t;
    FH5T_NATIVE_B64: hid_t;
    FH5T_NATIVE_OPAQUE: hid_t;
    FH5T_NATIVE_HADDR: hid_t;
    FH5T_NATIVE_HSIZE: hid_t;
    FH5T_NATIVE_HSSIZE: hid_t;
    FH5T_NATIVE_HERR: hid_t;
    FH5T_NATIVE_HBOOL: hid_t;
    FH5T_NATIVE_INT8: hid_t;
    FH5T_NATIVE_UINT8: hid_t;
    FH5T_NATIVE_INT_LEAST8: hid_t;
    FH5T_NATIVE_UINT_LEAST8: hid_t;
    FH5T_NATIVE_INT_FAST8: hid_t;
    FH5T_NATIVE_UINT_FAST8: hid_t;
    FH5T_NATIVE_INT16: hid_t;
    FH5T_NATIVE_UINT16: hid_t;
    FH5T_NATIVE_INT_LEAST16: hid_t;
    FH5T_NATIVE_UINT_LEAST16: hid_t;
    FH5T_NATIVE_INT_FAST16: hid_t;
    FH5T_NATIVE_UINT_FAST16: hid_t;
    FH5T_NATIVE_INT32: hid_t;
    FH5T_NATIVE_UINT32: hid_t;
    FH5T_NATIVE_INT_LEAST32: hid_t;
    FH5T_NATIVE_UINT_LEAST32: hid_t;
    FH5T_NATIVE_INT_FAST32: hid_t;
    FH5T_NATIVE_UINT_FAST32: hid_t;
    FH5T_NATIVE_INT64: hid_t;
    FH5T_NATIVE_UINT64: hid_t;
    FH5T_NATIVE_INT_LEAST64: hid_t;
    FH5T_NATIVE_UINT_LEAST64: hid_t;
    FH5T_NATIVE_INT_FAST64: hid_t;
    FH5T_NATIVE_UINT_FAST64: hid_t;
    FH5E_ERR_CLS: hid_t;
    FH5P_CLS_ROOT_ID: hid_t;
    FH5P_CLS_OBJECT_CREATE_ID: hid_t;
    FH5P_CLS_FILE_CREATE_ID: hid_t;
    FH5P_CLS_FILE_ACCESS_ID: hid_t;
    FH5P_CLS_DATASET_CREATE_ID: hid_t;
    FH5P_CLS_DATASET_ACCESS_ID: hid_t;
    FH5P_CLS_DATASET_XFER_ID: hid_t;
    FH5P_CLS_FILE_MOUNT_ID: hid_t;
    FH5P_CLS_GROUP_CREATE_ID: hid_t;
    FH5P_CLS_GROUP_ACCESS_ID: hid_t;
    FH5P_CLS_DATATYPE_CREATE_ID: hid_t;
    FH5P_CLS_DATATYPE_ACCESS_ID: hid_t;
    FH5P_CLS_STRING_CREATE_ID: hid_t;
    FH5P_CLS_ATTRIBUTE_CREATE_ID: hid_t;
    FH5P_CLS_OBJECT_COPY_ID: hid_t;
    FH5P_CLS_LINK_CREATE_ID: hid_t;
    FH5P_CLS_LINK_ACCESS_ID: hid_t;
    FH5P_LST_FILE_CREATE_ID: hid_t;
    FH5P_LST_FILE_ACCESS_ID: hid_t;
    FH5P_LST_DATASET_CREATE_ID: hid_t;
    FH5P_LST_DATASET_ACCESS_ID: hid_t;
    FH5P_LST_DATASET_XFER_ID: hid_t;
    FH5P_LST_FILE_MOUNT_ID: hid_t;
    FH5P_LST_GROUP_CREATE_ID: hid_t;
    FH5P_LST_GROUP_ACCESS_ID: hid_t;
    FH5P_LST_DATATYPE_CREATE_ID: hid_t;
    FH5P_LST_DATATYPE_ACCESS_ID: hid_t;
    FH5P_LST_ATTRIBUTE_CREATE_ID: hid_t;
    FH5P_LST_OBJECT_COPY_ID: hid_t;
    FH5P_LST_LINK_CREATE_ID: hid_t;
    FH5P_LST_LINK_ACCESS_ID: hid_t;

  public
    constructor Create(APath: string);
    destructor Destroy; override;

    function H5open: herr_t;
    function H5close: herr_t;
    function H5dont_atexit: herr_t;
    function H5garbage_collect: herr_t;
    function H5set_free_list_limits(reg_global_lim: Integer; reg_list_lim: Integer; arr_global_lim: Integer; arr_list_lim: Integer; blk_global_lim: Integer; blk_list_lim: Integer): herr_t;
    function H5get_libversion(majnum: PCardinal; minnum: PCardinal; relnum: PCardinal): herr_t;
    function H5check_version(majnum: Cardinal; minnum: Cardinal; relnum: Cardinal): herr_t;
    function H5free_memory(mem: Pointer): herr_t;
    function H5Iregister(typ: H5I_type_t; obj: Pointer): hid_t;
    function H5Iobject_verify(id: hid_t; id_type: H5I_type_t): Pointer;
    function H5Iremove_verify(id: hid_t; id_type: H5I_type_t): Pointer;
    function H5Iget_type(id: hid_t): H5I_type_t;
    function H5Iget_file_id(id: hid_t): hid_t;
    function H5Iget_name(id: hid_t; name: PAnsiChar; size: size_t): ssize_t;
    function H5Iinc_ref(id: hid_t): Integer;
    function H5Idec_ref(id: hid_t): Integer;
    function H5Iget_ref(id: hid_t): Integer;
    function H5Iregister_type(hash_size: size_t; reserved: Cardinal; free_func: H5I_free_t): H5I_type_t;
    function H5Iclear_type(typ: H5I_type_t; force: hbool_t): herr_t;
    function H5Idestroy_type(typ: H5I_type_t): herr_t;
    function H5Iinc_type_ref(typ: H5I_type_t): Integer;
    function H5Idec_type_ref(typ: H5I_type_t): Integer;
    function H5Iget_type_ref(typ: H5I_type_t): Integer;
    function H5Isearch(typ: H5I_type_t; func: H5I_search_func_t; key: Pointer): Pointer;
    function H5Inmembers(typ: H5I_type_t; num_members: Phsize_t): herr_t;
    function H5Itype_exists(typ: H5I_type_t): htri_t;
    function H5Iis_valid(id: hid_t): htri_t;
    function H5Zregister(cls: Pointer): herr_t;
    function H5Zunregister(id: H5Z_filter_t): herr_t;
    function H5Zfilter_avail(id: H5Z_filter_t): htri_t;
    function H5Zget_filter_info(filter: H5Z_filter_t; filter_config_flags: PCardinal): herr_t;
    function H5Tcreate(typ: H5T_class_t; size: size_t): hid_t;
    function H5Tcopy(type_id: hid_t): hid_t;
    function H5Tclose(type_id: hid_t): herr_t;
    function H5Tequal(type1_id: hid_t; type2_id: hid_t): htri_t;
    function H5Tlock(type_id: hid_t): herr_t;
    function H5Tcommit2(loc_id: hid_t; name: PAnsiChar; type_id: hid_t; lcpl_id: hid_t; tcpl_id: hid_t; tapl_id: hid_t): herr_t;
    function H5Topen2(loc_id: hid_t; name: PAnsiChar; tapl_id: hid_t): hid_t;
    function H5Tcommit_anon(loc_id: hid_t; type_id: hid_t; tcpl_id: hid_t; tapl_id: hid_t): herr_t;
    function H5Tget_create_plist(type_id: hid_t): hid_t;
    function H5Tcommitted(type_id: hid_t): htri_t;
    function H5Tencode(obj_id: hid_t; buf: Pointer; nalloc: Psize_t): herr_t;
    function H5Tdecode(buf: Pointer): hid_t;
    function H5Tinsert(parent_id: hid_t; name: PAnsiChar; offset: size_t; member_id: hid_t): herr_t;
    function H5Tpack(type_id: hid_t): herr_t;
    function H5Tenum_create(base_id: hid_t): hid_t;
    function H5Tenum_insert(typ: hid_t; name: PAnsiChar; value: Pointer): herr_t;
    function H5Tenum_nameof(typ: hid_t; value: Pointer; name: PAnsiChar; size: size_t): herr_t;
    function H5Tenum_valueof(typ: hid_t; name: PAnsiChar; value: Pointer): herr_t;
    function H5Tvlen_create(base_id: hid_t): hid_t;
    function H5Tarray_create2(base_id: hid_t; ndims: Cardinal; dim: Phsize_t): hid_t;
    function H5Tget_array_ndims(type_id: hid_t): Integer;
    function H5Tget_array_dims2(type_id: hid_t; dims: Phsize_t): Integer;
    function H5Tset_tag(typ: hid_t; tag: PAnsiChar): herr_t;
    function H5Tget_tag(typ: hid_t): PAnsiChar;
    function H5Tget_super(typ: hid_t): hid_t;
    function H5Tget_class(type_id: hid_t): H5T_class_t;
    function H5Tdetect_class(type_id: hid_t; cls: H5T_class_t): htri_t;
    function H5Tget_size(type_id: hid_t): size_t;
    function H5Tget_order(type_id: hid_t): H5T_order_t;
    function H5Tget_precision(type_id: hid_t): size_t;
    function H5Tget_offset(type_id: hid_t): Integer;
    function H5Tget_pad(type_id: hid_t; lsb: PH5T_pad_t; msb: PH5T_pad_t): herr_t;
    function H5Tget_sign(type_id: hid_t): H5T_sign_t;
    function H5Tget_fields(type_id: hid_t; spos: Psize_t; epos: Psize_t; esize: Psize_t; mpos: Psize_t; msize: Psize_t): herr_t;
    function H5Tget_ebias(type_id: hid_t): size_t;
    function H5Tget_norm(type_id: hid_t): H5T_norm_t;
    function H5Tget_inpad(type_id: hid_t): H5T_pad_t;
    function H5Tget_strpad(type_id: hid_t): H5T_str_t;
    function H5Tget_nmembers(type_id: hid_t): Integer;
    function H5Tget_member_name(type_id: hid_t; membno: Cardinal): PAnsiChar;
    function H5Tget_member_index(type_id: hid_t; name: PAnsiChar): Integer;
    function H5Tget_member_offset(type_id: hid_t; membno: Cardinal): size_t;
    function H5Tget_member_class(type_id: hid_t; membno: Cardinal): H5T_class_t;
    function H5Tget_member_type(type_id: hid_t; membno: Cardinal): hid_t;
    function H5Tget_member_value(type_id: hid_t; membno: Cardinal; value: Pointer): herr_t;
    function H5Tget_cset(type_id: hid_t): H5T_cset_t;
    function H5Tis_variable_str(type_id: hid_t): htri_t;
    function H5Tget_native_type(type_id: hid_t; direction: H5T_direction_t): hid_t;
    function H5Tset_size(type_id: hid_t; size: size_t): herr_t;
    function H5Tset_order(type_id: hid_t; order: H5T_order_t): herr_t;
    function H5Tset_precision(type_id: hid_t; prec: size_t): herr_t;
    function H5Tset_offset(type_id: hid_t; offset: size_t): herr_t;
    function H5Tset_pad(type_id: hid_t; lsb: H5T_pad_t; msb: H5T_pad_t): herr_t;
    function H5Tset_sign(type_id: hid_t; sign: H5T_sign_t): herr_t;
    function H5Tset_fields(type_id: hid_t; spos: size_t; epos: size_t; esize: size_t; mpos: size_t; msize: size_t): herr_t;
    function H5Tset_ebias(type_id: hid_t; ebias: size_t): herr_t;
    function H5Tset_norm(type_id: hid_t; norm: H5T_norm_t): herr_t;
    function H5Tset_inpad(type_id: hid_t; pad: H5T_pad_t): herr_t;
    function H5Tset_cset(type_id: hid_t; cset: H5T_cset_t): herr_t;
    function H5Tset_strpad(type_id: hid_t; strpad: H5T_str_t): herr_t;
    function H5Tregister(pers: H5T_pers_t; name: PAnsiChar; src_id: hid_t; dst_id: hid_t; func: H5T_conv_t): herr_t;
    function H5Tunregister(pers: H5T_pers_t; name: PAnsiChar; src_id: hid_t; dst_id: hid_t; func: H5T_conv_t): herr_t;
    function H5Tfind(src_id: hid_t; dst_id: hid_t; pcdata: PPH5T_cdata_t): H5T_conv_t;
    function H5Tcompiler_conv(src_id: hid_t; dst_id: hid_t): htri_t;
    function H5Tconvert(src_id: hid_t; dst_id: hid_t; nelmts: size_t; buf: Pointer; background: Pointer; plist_id: hid_t): herr_t;
    function H5Dcreate2(loc_id: hid_t; name: PAnsiChar; type_id: hid_t; space_id: hid_t; lcpl_id: hid_t; dcpl_id: hid_t; dapl_id: hid_t): hid_t;
    function H5Dcreate_anon(file_id: hid_t; type_id: hid_t; space_id: hid_t; plist_id: hid_t; dapl_id: hid_t): hid_t;
    function H5Dopen2(file_id: hid_t; name: PAnsiChar; dapl_id: hid_t): hid_t;
    function H5Dclose(dset_id: hid_t): herr_t;
    function H5Dget_space(dset_id: hid_t): hid_t;
    function H5Dget_space_status(dset_id: hid_t; allocation: PH5D_space_status_t): herr_t;
    function H5Dget_type(dset_id: hid_t): hid_t;
    function H5Dget_create_plist(dset_id: hid_t): hid_t;
    function H5Dget_access_plist(dset_id: hid_t): hid_t;
    function H5Dget_storage_size(dset_id: hid_t): hsize_t;
    function H5Dget_offset(dset_id: hid_t): haddr_t;
    function H5Dread(dset_id: hid_t; mem_type_id: hid_t; mem_space_id: hid_t; file_space_id: hid_t; plist_id: hid_t; buf: Pointer): herr_t;
    function H5Dwrite(dset_id: hid_t; mem_type_id: hid_t; mem_space_id: hid_t; file_space_id: hid_t; plist_id: hid_t; buf: Pointer): herr_t;
    function H5Diterate(buf: Pointer; type_id: hid_t; space_id: hid_t; op: H5D_operator_t; operator_data: Pointer): herr_t;
    function H5Dvlen_reclaim(type_id: hid_t; space_id: hid_t; plist_id: hid_t; buf: Pointer): herr_t;
    function H5Dvlen_get_buf_size(dataset_id: hid_t; type_id: hid_t; space_id: hid_t; size: Phsize_t): herr_t;
    function H5Dfill(fill: Pointer; fill_type: hid_t; buf: Pointer; buf_type: hid_t; space: hid_t): herr_t;
    function H5Dset_extent(dset_id: hid_t; size: Phsize_t): herr_t;
    function H5Dscatter(op: H5D_scatter_func_t; op_data: Pointer; type_id: hid_t; dst_space_id: hid_t; dst_buf: Pointer): herr_t;
    function H5Dgather(src_space_id: hid_t; src_buf: Pointer; type_id: hid_t; dst_buf_size: size_t; dst_buf: Pointer; op: H5D_gather_func_t; op_data: Pointer): herr_t;
    function H5Ddebug(dset_id: hid_t): herr_t;
    function H5Eregister_class(cls_name: PAnsiChar; lib_name: PAnsiChar; version: PAnsiChar): hid_t;
    function H5Eunregister_class(class_id: hid_t): herr_t;
    function H5Eclose_msg(err_id: hid_t): herr_t;
    function H5Ecreate_msg(cls: hid_t; msg_type: H5E_type_t; msg: PAnsiChar): hid_t;
    function H5Ecreate_stack: hid_t;
    function H5Eget_current_stack: hid_t;
    function H5Eclose_stack(stack_id: hid_t): herr_t;
    function H5Eget_class_name(class_id: hid_t; name: PAnsiChar; size: size_t): ssize_t;
    function H5Eset_current_stack(err_stack_id: hid_t): herr_t;
    // function H5Epush2(err_stack: hid_t; file_: PAnsiChar; func: PAnsiChar; line: Cardinal; cls_id: hid_t; maj_id: hid_t; min_id: hid_t; msg: PAnsiChar): herr_t; cdecl; varargs;
    function H5Epop(err_stack: hid_t; count: size_t): herr_t;
    function H5Eprint2(err_stack: hid_t; stream: PFILE): herr_t;
    function H5Ewalk2(err_stack: hid_t; direction: H5E_direction_t; func: H5E_walk2_t; client_data: Pointer): herr_t;
    function H5Eget_auto2(estack_id: hid_t; func: PH5E_auto2_t; client_data: PPointer): herr_t;
    function H5Eset_auto2(estack_id: hid_t; func: H5E_auto2_t; client_data: Pointer): herr_t;
    function H5Eclear2(err_stack: hid_t): herr_t;
    function H5Eauto_is_v2(err_stack: hid_t; is_stack: PCardinal): herr_t;
    function H5Eget_msg(msg_id: hid_t; typ: PH5E_type_t; msg: PAnsiChar; size: size_t): ssize_t;
    function H5Eget_num(error_stack_id: hid_t): ssize_t;
    function H5Screate(typ: H5S_class_t): hid_t;
    function H5Screate_simple(rank: Integer; dims: Phsize_t; maxdims: Phsize_t): hid_t;
    function H5Sset_extent_simple(space_id: hid_t; rank: Integer; dims: Phsize_t; max: Phsize_t): herr_t;
    function H5Scopy(space_id: hid_t): hid_t;
    function H5Sclose(space_id: hid_t): herr_t;
    function H5Sencode(obj_id: hid_t; buf: Pointer; nalloc: Psize_t): herr_t;
    function H5Sdecode(buf: Pointer): hid_t;
    function H5Sget_simple_extent_npoints(space_id: hid_t): hssize_t;
    function H5Sget_simple_extent_ndims(space_id: hid_t): Integer;
    function H5Sget_simple_extent_dims(space_id: hid_t; dims: Phsize_t; maxdims: Phsize_t): Integer;
    function H5Sis_simple(space_id: hid_t): htri_t;
    function H5Sget_select_npoints(spaceid: hid_t): hssize_t;
    function H5Sselect_hyperslab(space_id: hid_t; op: H5S_seloper_t; start: Phsize_t; _stride: Phsize_t; count: Phsize_t; _block: Phsize_t): herr_t;
    function H5Sselect_elements(space_id: hid_t; op: H5S_seloper_t; num_elem: size_t; coord: Phsize_t): herr_t;
    function H5Sget_simple_extent_type(space_id: hid_t): H5S_class_t;
    function H5Sset_extent_none(space_id: hid_t): herr_t;
    function H5Sextent_copy(dst_id: hid_t; src_id: hid_t): herr_t;
    function H5Sextent_equal(sid1: hid_t; sid2: hid_t): htri_t;
    function H5Sselect_all(spaceid: hid_t): herr_t;
    function H5Sselect_none(spaceid: hid_t): herr_t;
    function H5Soffset_simple(space_id: hid_t; offset: Phssize_t): herr_t;
    function H5Sselect_valid(spaceid: hid_t): htri_t;
    function H5Sget_select_hyper_nblocks(spaceid: hid_t): hssize_t;
    function H5Sget_select_elem_npoints(spaceid: hid_t): hssize_t;
    function H5Sget_select_hyper_blocklist(spaceid: hid_t; startblock: hsize_t; numblocks: hsize_t; buf: Phsize_t): herr_t;
    function H5Sget_select_elem_pointlist(spaceid: hid_t; startpoint: hsize_t; numpoints: hsize_t; buf: Phsize_t): herr_t;
    function H5Sget_select_bounds(spaceid: hid_t; start: Phsize_t; end_: Phsize_t): herr_t;
    function H5Sget_select_type(spaceid: hid_t): H5S_sel_type;
    function H5Lmove(src_loc: hid_t; src_name: PAnsiChar; dst_loc: hid_t; dst_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
    function H5Lcopy(src_loc: hid_t; src_name: PAnsiChar; dst_loc: hid_t; dst_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
    function H5Lcreate_hard(cur_loc: hid_t; cur_name: PAnsiChar; dst_loc: hid_t; dst_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
    function H5Lcreate_soft(link_target: PAnsiChar; link_loc_id: hid_t; link_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
    function H5Ldelete(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): herr_t;
    function H5Ldelete_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; lapl_id: hid_t): herr_t;
    function H5Lget_val(loc_id: hid_t; name: PAnsiChar; buf: Pointer; size: size_t; lapl_id: hid_t): herr_t;
    function H5Lget_val_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; buf: Pointer; size: size_t; lapl_id: hid_t): herr_t;
    function H5Lexists(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): htri_t;
    function H5Lget_info(loc_id: hid_t; name: PAnsiChar; linfo: PH5L_info_t; lapl_id: hid_t): herr_t;
    function H5Lget_info_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; linfo: PH5L_info_t; lapl_id: hid_t): herr_t;
    function H5Lget_name_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; name: PAnsiChar; size: size_t; lapl_id: hid_t): ssize_t;
    function H5Literate(grp_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5L_iterate_t; op_data: Pointer): herr_t;
    function H5Literate_by_name(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5L_iterate_t; op_data: Pointer; lapl_id: hid_t): herr_t;
    function H5Lvisit(grp_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; op: H5L_iterate_t; op_data: Pointer): herr_t;
    function H5Lvisit_by_name(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; op: H5L_iterate_t; op_data: Pointer; lapl_id: hid_t): herr_t;
    function H5Lcreate_ud(link_loc_id: hid_t; link_name: PAnsiChar; link_type: H5L_type_t; udata: Pointer; udata_size: size_t; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
    function H5Lregister(cls: PH5L_class_t): herr_t;
    function H5Lunregister(id: H5L_type_t): herr_t;
    function H5Lis_registered(id: H5L_type_t): htri_t;
    function H5Lunpack_elink_val(ext_linkval: Pointer; link_size: size_t; flags: PCardinal; filename: PPAnsiChar; obj_path: PPAnsiChar): herr_t;
    function H5Lcreate_external(file_name: PAnsiChar; obj_name: PAnsiChar; link_loc_id: hid_t; link_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
    function H5Oopen(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): hid_t;
    function H5Oopen_by_addr(loc_id: hid_t; addr: haddr_t): hid_t;
    function H5Oopen_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; lapl_id: hid_t): hid_t;
    function H5Oexists_by_name(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): htri_t;
    function H5Oget_info(loc_id: hid_t; oinfo: PH5O_info_t): herr_t;
    function H5Oget_info_by_name(loc_id: hid_t; name: PAnsiChar; oinfo: PH5O_info_t; lapl_id: hid_t): herr_t;
    function H5Oget_info_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; oinfo: PH5O_info_t; lapl_id: hid_t): herr_t;
    function H5Olink(obj_id: hid_t; new_loc_id: hid_t; new_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
    function H5Oincr_refcount(object_id: hid_t): herr_t;
    function H5Odecr_refcount(object_id: hid_t): herr_t;
    function H5Ocopy(src_loc_id: hid_t; src_name: PAnsiChar; dst_loc_id: hid_t; dst_name: PAnsiChar; ocpypl_id: hid_t; lcpl_id: hid_t): herr_t;
    function H5Oset_comment(obj_id: hid_t; comment: PAnsiChar): herr_t;
    function H5Oset_comment_by_name(loc_id: hid_t; name: PAnsiChar; comment: PAnsiChar; lapl_id: hid_t): herr_t;
    function H5Oget_comment(obj_id: hid_t; comment: PAnsiChar; bufsize: size_t): ssize_t;
    function H5Oget_comment_by_name(loc_id: hid_t; name: PAnsiChar; comment: PAnsiChar; bufsize: size_t; lapl_id: hid_t): ssize_t;
    function H5Ovisit(obj_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; op: H5O_iterate_t; op_data: Pointer): herr_t;
    function H5Ovisit_by_name(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; op: H5O_iterate_t; op_data: Pointer; lapl_id: hid_t): herr_t;
    function H5Oclose(object_id: hid_t): herr_t;
    function H5Fis_hdf5(filename: PAnsiChar): htri_t;
    function H5Fcreate(filename: PAnsiChar; flags: Cardinal; create_plist: hid_t; access_plist: hid_t): hid_t;
    function H5Fopen(filename: PAnsiChar; flags: Cardinal; access_plist: hid_t): hid_t;
    function H5Freopen(file_id: hid_t): hid_t;
    function H5Fflush(object_id: hid_t; scope: H5F_scope_t): herr_t;
    function H5Fclose(file_id: hid_t): herr_t;
    function H5Fget_create_plist(file_id: hid_t): hid_t;
    function H5Fget_access_plist(file_id: hid_t): hid_t;
    function H5Fget_intent(file_id: hid_t; intent: PCardinal): herr_t;
    function H5Fget_obj_count(file_id: hid_t; types: Cardinal): ssize_t;
    function H5Fget_obj_ids(file_id: hid_t; types: Cardinal; max_objs: size_t; obj_id_list: Phid_t): ssize_t;
    function H5Fget_vfd_handle(file_id: hid_t; fapl: hid_t; file_handle: PPointer): herr_t;
    function H5Fmount(loc: hid_t; name: PAnsiChar; child: hid_t; plist: hid_t): herr_t;
    function H5Funmount(loc: hid_t; name: PAnsiChar): herr_t;
    function H5Fget_freespace(file_id: hid_t): hssize_t;
    function H5Fget_filesize(file_id: hid_t; size: Phsize_t): herr_t;
    function H5Fget_file_image(file_id: hid_t; buf_ptr: Pointer; buf_len: size_t): ssize_t;
    function H5Fget_mdc_config(file_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t;
    function H5Fset_mdc_config(file_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t;
    function H5Fget_mdc_hit_rate(file_id: hid_t; hit_rate_ptr: Pdouble): herr_t;
    function H5Fget_mdc_size(file_id: hid_t; max_size_ptr: Psize_t; min_clean_size_ptr: Psize_t; cur_size_ptr: Psize_t; cur_num_entries_ptr: PInteger): herr_t;
    function H5Freset_mdc_hit_rate_stats(file_id: hid_t): herr_t;
    function H5Fget_name(obj_id: hid_t; name: PAnsiChar; size: size_t): ssize_t;
    function H5Fget_info(obj_id: hid_t; bh_info: PH5F_info_t): herr_t;
    function H5Fclear_elink_file_cache(file_id: hid_t): herr_t;
    function H5Acreate2(loc_id: hid_t; attr_name: PAnsiChar; type_id: hid_t; space_id: hid_t; acpl_id: hid_t; aapl_id: hid_t): hid_t;
    function H5Acreate_by_name(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; type_id: hid_t; space_id: hid_t; acpl_id: hid_t; aapl_id: hid_t; lapl_id: hid_t): hid_t;
    function H5Aopen(obj_id: hid_t; attr_name: PAnsiChar; aapl_id: hid_t): hid_t;
    function H5Aopen_by_name(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; aapl_id: hid_t; lapl_id: hid_t): hid_t;
    function H5Aopen_by_idx(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; aapl_id: hid_t; lapl_id: hid_t): hid_t;
    function H5Awrite(attr_id: hid_t; type_id: hid_t; buf: Pointer): herr_t;
    function H5Aread(attr_id: hid_t; type_id: hid_t; buf: Pointer): herr_t;
    function H5Aclose(attr_id: hid_t): herr_t;
    function H5Aget_space(attr_id: hid_t): hid_t;
    function H5Aget_type(attr_id: hid_t): hid_t;
    function H5Aget_create_plist(attr_id: hid_t): hid_t;
    function H5Aget_name(attr_id: hid_t; buf_size: size_t; buf: PAnsiChar): ssize_t;
    function H5Aget_name_by_idx(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; name: PAnsiChar; size: size_t; lapl_id: hid_t): ssize_t;
    function H5Aget_storage_size(attr_id: hid_t): hsize_t;
    function H5Aget_info(attr_id: hid_t; ainfo: PH5A_info_t): herr_t;
    function H5Aget_info_by_name(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; ainfo: PH5A_info_t; lapl_id: hid_t): herr_t;
    function H5Aget_info_by_idx(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; ainfo: PH5A_info_t; lapl_id: hid_t): herr_t;
    function H5Arename(loc_id: hid_t; old_name: PAnsiChar; new_name: PAnsiChar): herr_t;
    function H5Arename_by_name(loc_id: hid_t; obj_name: PAnsiChar; old_attr_name: PAnsiChar; new_attr_name: PAnsiChar; lapl_id: hid_t): herr_t;
    function H5Aiterate2(loc_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5A_operator2_t; op_data: Pointer): herr_t;
    function H5Aiterate_by_name(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5A_operator2_t; op_data: Pointer; lapd_id: hid_t): herr_t;
    function H5Adelete(loc_id: hid_t; name: PAnsiChar): herr_t;
    function H5Adelete_by_name(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; lapl_id: hid_t): herr_t;
    function H5Adelete_by_idx(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; lapl_id: hid_t): herr_t;
    function H5Aexists(obj_id: hid_t; attr_name: PAnsiChar): htri_t;
    function H5Aexists_by_name(obj_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; lapl_id: hid_t): htri_t;
    function H5FDregister(cls: PH5FD_class_t): hid_t;
    function H5FDunregister(driver_id: hid_t): herr_t;
    function H5FDopen(name: PAnsiChar; flags: Cardinal; fapl_id: hid_t; maxaddr: haddr_t): PH5FD_t;
    function H5FDclose(file_: PH5FD_t): herr_t;
    function H5FDcmp(f1: PH5FD_t; f2: PH5FD_t): Integer;
    function H5FDquery(f: PH5FD_t; flags: PCardinal): Integer;
    function H5FDalloc(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; size: hsize_t): haddr_t;
    function H5FDfree(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; addr: haddr_t; size: hsize_t): herr_t;
    function H5FDget_eoa(file_: PH5FD_t; typ: H5FD_mem_t): haddr_t;
    function H5FDset_eoa(file_: PH5FD_t; typ: H5FD_mem_t; eoa: haddr_t): herr_t;
    function H5FDget_eof(file_: PH5FD_t): haddr_t;
    function H5FDget_vfd_handle(file_: PH5FD_t; fapl: hid_t; file_handle: PPointer): herr_t;
    function H5FDread(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; addr: haddr_t; size: size_t; buf: Pointer): herr_t;
    function H5FDwrite(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; addr: haddr_t; size: size_t; buf: Pointer): herr_t;
    function H5FDflush(file_: PH5FD_t; dxpl_id: hid_t; closing: Cardinal): herr_t;
    function H5FDtruncate(file_: PH5FD_t; dxpl_id: hid_t; closing: hbool_t): herr_t;
    function H5Gcreate2(loc_id: hid_t; name: PAnsiChar; lcpl_id: hid_t; gcpl_id: hid_t; gapl_id: hid_t): hid_t;
    function H5Gcreate_anon(loc_id: hid_t; gcpl_id: hid_t; gapl_id: hid_t): hid_t;
    function H5Gopen2(loc_id: hid_t; name: PAnsiChar; gapl_id: hid_t): hid_t;
    function H5Gget_create_plist(group_id: hid_t): hid_t;
    function H5Gget_info(loc_id: hid_t; ginfo: PH5G_info_t): herr_t;
    function H5Gget_info_by_name(loc_id: hid_t; name: PAnsiChar; ginfo: PH5G_info_t; lapl_id: hid_t): herr_t;
    function H5Gget_info_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; ginfo: PH5G_info_t; lapl_id: hid_t): herr_t;
    function H5Gclose(group_id: hid_t): herr_t;
    function H5Rcreate(ref: Pointer; loc_id: hid_t; name: PAnsiChar; ref_type: H5R_type_t; space_id: hid_t): herr_t;
    function H5Rdereference(dataset: hid_t; ref_type: H5R_type_t; ref: Pointer): hid_t;
    function H5Rget_region(dataset: hid_t; ref_type: H5R_type_t; ref: Pointer): hid_t;
    function H5Rget_obj_type2(id: hid_t; ref_type: H5R_type_t; _ref: Pointer; obj_type: PH5O_type_t): herr_t;
    function H5Rget_name(loc_id: hid_t; ref_type: H5R_type_t; ref: Pointer; name: PAnsiChar; size: size_t): ssize_t;
    function H5Pcreate_class(parent: hid_t; name: PAnsiChar; cls_create: H5P_cls_create_func_t; create_data: Pointer; cls_copy: H5P_cls_copy_func_t; copy_data: Pointer; cls_close: H5P_cls_close_func_t; close_data: Pointer): hid_t;
    function H5Pget_class_name(pclass_id: hid_t): PAnsiChar;
    function H5Pcreate(cls_id: hid_t): hid_t;
    function H5Pregister2(cls_id: hid_t; name: PAnsiChar; size: size_t; def_value: Pointer; prp_create: H5P_prp_create_func_t; prp_set: H5P_prp_set_func_t; prp_get: H5P_prp_get_func_t; prp_del: H5P_prp_delete_func_t; prp_copy: H5P_prp_copy_func_t; prp_cmp: H5P_prp_compare_func_t; prp_close: H5P_prp_close_func_t): herr_t;
    function H5Pinsert2(plist_id: hid_t; name: PAnsiChar; size: size_t; value: Pointer; prp_set: H5P_prp_set_func_t; prp_get: H5P_prp_get_func_t; prp_delete: H5P_prp_delete_func_t; prp_copy: H5P_prp_copy_func_t; prp_cmp: H5P_prp_compare_func_t; prp_close: H5P_prp_close_func_t): herr_t;
    function H5Pset(plist_id: hid_t; name: PAnsiChar; value: Pointer): herr_t;
    function H5Pexist(plist_id: hid_t; name: PAnsiChar): htri_t;
    function H5Pget_size(id: hid_t; name: PAnsiChar; size: Psize_t): herr_t;
    function H5Pget_nprops(id: hid_t; nprops: Psize_t): herr_t;
    function H5Pget_class(plist_id: hid_t): hid_t;
    function H5Pget_class_parent(pclass_id: hid_t): hid_t;
    function H5Pget(plist_id: hid_t; name: PAnsiChar; value: Pointer): herr_t;
    function H5Pequal(id1: hid_t; id2: hid_t): htri_t;
    function H5Pisa_class(plist_id: hid_t; pclass_id: hid_t): htri_t;
    function H5Piterate(id: hid_t; idx: PInteger; iter_func: H5P_iterate_t; iter_data: Pointer): Integer;
    function H5Pcopy_prop(dst_id: hid_t; src_id: hid_t; name: PAnsiChar): herr_t;
    function H5Premove(plist_id: hid_t; name: PAnsiChar): herr_t;
    function H5Punregister(pclass_id: hid_t; name: PAnsiChar): herr_t;
    function H5Pclose_class(plist_id: hid_t): herr_t;
    function H5Pclose(plist_id: hid_t): herr_t;
    function H5Pcopy(plist_id: hid_t): hid_t;
    function H5Pset_attr_phase_change(plist_id: hid_t; max_compact: Cardinal; min_dense: Cardinal): herr_t;
    function H5Pget_attr_phase_change(plist_id: hid_t; max_compact: PCardinal; min_dense: PCardinal): herr_t;
    function H5Pset_attr_creation_order(plist_id: hid_t; crt_order_flags: Cardinal): herr_t;
    function H5Pget_attr_creation_order(plist_id: hid_t; crt_order_flags: PCardinal): herr_t;
    function H5Pset_obj_track_times(plist_id: hid_t; track_times: hbool_t): herr_t;
    function H5Pget_obj_track_times(plist_id: hid_t; track_times: Phbool_t): herr_t;
    function H5Pmodify_filter(plist_id: hid_t; filter: H5Z_filter_t; flags: Cardinal; cd_nelmts: size_t; cd_values: PCardinal): herr_t;
    function H5Pset_filter(plist_id: hid_t; filter: H5Z_filter_t; flags: Cardinal; cd_nelmts: size_t; c_values: PCardinal): herr_t;
    function H5Pget_nfilters(plist_id: hid_t): Integer;
    function H5Pget_filter2(plist_id: hid_t; filter: Cardinal; flags: PCardinal; cd_nelmts: Psize_t; cd_values: PCardinal; namelen: size_t; name: PAnsiChar; filter_config: PCardinal): H5Z_filter_t;
    function H5Pget_filter_by_id2(plist_id: hid_t; id: H5Z_filter_t; flags: PCardinal; cd_nelmts: Psize_t; cd_values: PCardinal; namelen: size_t; name: PAnsiChar; filter_config: PCardinal): herr_t;
    function H5Pall_filters_avail(plist_id: hid_t): htri_t;
    function H5Premove_filter(plist_id: hid_t; filter: H5Z_filter_t): herr_t;
    function H5Pset_deflate(plist_id: hid_t; aggression: Cardinal): herr_t;
    function H5Pset_fletcher32(plist_id: hid_t): herr_t;
    function H5Pget_version(plist_id: hid_t; boot: PCardinal; freelist: PCardinal; stab: PCardinal; shhdr: PCardinal): herr_t;
    function H5Pset_userblock(plist_id: hid_t; size: hsize_t): herr_t;
    function H5Pget_userblock(plist_id: hid_t; size: Phsize_t): herr_t;
    function H5Pset_sizes(plist_id: hid_t; sizeof_addr: size_t; sizeof_size: size_t): herr_t;
    function H5Pget_sizes(plist_id: hid_t; sizeof_addr: Psize_t; sizeof_size: Psize_t): herr_t;
    function H5Pset_sym_k(plist_id: hid_t; ik: Cardinal; lk: Cardinal): herr_t;
    function H5Pget_sym_k(plist_id: hid_t; ik: PCardinal; lk: PCardinal): herr_t;
    function H5Pset_istore_k(plist_id: hid_t; ik: Cardinal): herr_t;
    function H5Pget_istore_k(plist_id: hid_t; ik: PCardinal): herr_t;
    function H5Pset_shared_mesg_nindexes(plist_id: hid_t; nindexes: Cardinal): herr_t;
    function H5Pget_shared_mesg_nindexes(plist_id: hid_t; nindexes: PCardinal): herr_t;
    function H5Pset_shared_mesg_index(plist_id: hid_t; index_num: Cardinal; mesg_type_flags: Cardinal; min_mesg_size: Cardinal): herr_t;
    function H5Pget_shared_mesg_index(plist_id: hid_t; index_num: Cardinal; mesg_type_flags: PCardinal; min_mesg_size: PCardinal): herr_t;
    function H5Pset_shared_mesg_phase_change(plist_id: hid_t; max_list: Cardinal; min_btree: Cardinal): herr_t;
    function H5Pget_shared_mesg_phase_change(plist_id: hid_t; max_list: PCardinal; min_btree: PCardinal): herr_t;
    function H5Pset_alignment(fapl_id: hid_t; threshold: hsize_t; alignment: hsize_t): herr_t;
    function H5Pget_alignment(fapl_id: hid_t; threshold: Phsize_t; alignment: Phsize_t): herr_t;
    function H5Pset_driver(plist_id: hid_t; driver_id: hid_t; driver_info: Pointer): herr_t;
    function H5Pget_driver(plist_id: hid_t): hid_t;
    function H5Pget_driver_info(plist_id: hid_t): Pointer;
    function H5Pset_family_offset(fapl_id: hid_t; offset: hsize_t): herr_t;
    function H5Pget_family_offset(fapl_id: hid_t; offset: Phsize_t): herr_t;
    function H5Pset_multi_type(fapl_id: hid_t; typ: H5FD_mem_t): herr_t;
    function H5Pget_multi_type(fapl_id: hid_t; typ: PH5FD_mem_t): herr_t;
    function H5Pset_cache(plist_id: hid_t; mdc_nelmts: Integer; rdcc_nslots: size_t; rdcc_nbytes: size_t; rdcc_w0: double): herr_t;
    function H5Pget_cache(plist_id: hid_t; mdc_nelmts: PInteger; rdcc_nslots: Psize_t; rdcc_nbytes: Psize_t; rdcc_w0: Pdouble): herr_t;
    function H5Pset_mdc_config(plist_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t;
    function H5Pget_mdc_config(plist_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t;
    function H5Pset_gc_references(fapl_id: hid_t; gc_ref: Cardinal): herr_t;
    function H5Pget_gc_references(fapl_id: hid_t; gc_ref: PCardinal): herr_t;
    function H5Pset_fclose_degree(fapl_id: hid_t; degree: H5F_close_degree_t): herr_t;
    function H5Pget_fclose_degree(fapl_id: hid_t; degree: PH5F_close_degree_t): herr_t;
    function H5Pset_meta_block_size(fapl_id: hid_t; size: hsize_t): herr_t;
    function H5Pget_meta_block_size(fapl_id: hid_t; size: Phsize_t): herr_t;
    function H5Pset_sieve_buf_size(fapl_id: hid_t; size: size_t): herr_t;
    function H5Pget_sieve_buf_size(fapl_id: hid_t; size: Psize_t): herr_t;
    function H5Pset_small_data_block_size(fapl_id: hid_t; size: hsize_t): herr_t;
    function H5Pget_small_data_block_size(fapl_id: hid_t; size: Phsize_t): herr_t;
    function H5Pset_libver_bounds(plist_id: hid_t; low: H5F_libver_t; high: H5F_libver_t): herr_t;
    function H5Pget_libver_bounds(plist_id: hid_t; low: PH5F_libver_t; high: PH5F_libver_t): herr_t;
    function H5Pset_elink_file_cache_size(plist_id: hid_t; efc_size: Cardinal): herr_t;
    function H5Pget_elink_file_cache_size(plist_id: hid_t; efc_size: PCardinal): herr_t;
    function H5Pset_file_image(fapl_id: hid_t; buf_ptr: Pointer; buf_len: size_t): herr_t;
    function H5Pget_file_image(fapl_id: hid_t; buf_ptr_ptr: PPointer; buf_len_ptr: Psize_t): herr_t;
    function H5Pset_file_image_callbacks(fapl_id: hid_t; callbacks_ptr: PH5FD_file_image_callbacks_t): herr_t;
    function H5Pget_file_image_callbacks(fapl_id: hid_t; callbacks_ptr: PH5FD_file_image_callbacks_t): herr_t;
    function H5Pset_core_write_tracking(fapl_id: hid_t; is_enabled: hbool_t; page_size: size_t): herr_t;
    function H5Pget_core_write_tracking(fapl_id: hid_t; is_enabled: Phbool_t; page_size: Psize_t): herr_t;
    function H5Pset_layout(plist_id: hid_t; layout: H5D_layout_t): herr_t;
    function H5Pget_layout(plist_id: hid_t): H5D_layout_t;
    function H5Pset_chunk(plist_id: hid_t; ndims: Integer; dim: Phsize_t): herr_t;
    function H5Pget_chunk(plist_id: hid_t; max_ndims: Integer; dim: Phsize_t): Integer;
    function H5Pset_external(plist_id: hid_t; name: PAnsiChar; offset: off_t; size: hsize_t): herr_t;
    function H5Pget_external_count(plist_id: hid_t): Integer;
    function H5Pget_external(plist_id: hid_t; idx: Cardinal; name_size: size_t; name: PAnsiChar; offset: Poff_t; size: Phsize_t): herr_t;
    function H5Pset_szip(plist_id: hid_t; options_mask: Cardinal; pixels_per_block: Cardinal): herr_t;
    function H5Pset_shuffle(plist_id: hid_t): herr_t;
    function H5Pset_nbit(plist_id: hid_t): herr_t;
    function H5Pset_scaleoffset(plist_id: hid_t; scale_type: H5Z_SO_scale_type_t; scale_factor: Integer): herr_t;
    function H5Pset_fill_value(plist_id: hid_t; type_id: hid_t; value: Pointer): herr_t;
    function H5Pget_fill_value(plist_id: hid_t; type_id: hid_t; value: Pointer): herr_t;
    function H5Pfill_value_defined(plist: hid_t; status: PH5D_fill_value_t): herr_t;
    function H5Pset_alloc_time(plist_id: hid_t; alloc_time: H5D_alloc_time_t): herr_t;
    function H5Pget_alloc_time(plist_id: hid_t; alloc_time: PH5D_alloc_time_t): herr_t;
    function H5Pset_fill_time(plist_id: hid_t; fill_time: H5D_fill_time_t): herr_t;
    function H5Pget_fill_time(plist_id: hid_t; fill_time: PH5D_fill_time_t): herr_t;
    function H5Pset_chunk_cache(dapl_id: hid_t; rdcc_nslots: size_t; rdcc_nbytes: size_t; rdcc_w0: double): herr_t;
    function H5Pget_chunk_cache(dapl_id: hid_t; rdcc_nslots: Psize_t; rdcc_nbytes: Psize_t; rdcc_w0: Pdouble): herr_t;
    function H5Pset_data_transform(plist_id: hid_t; expression: PAnsiChar): herr_t;
    function H5Pget_data_transform(plist_id: hid_t; expression: PAnsiChar; size: size_t): ssize_t;
    function H5Pset_buffer(plist_id: hid_t; size: size_t; tconv: Pointer; bkg: Pointer): herr_t;
    function H5Pget_buffer(plist_id: hid_t; tconv: PPointer; bkg: PPointer): size_t;
    function H5Pset_preserve(plist_id: hid_t; status: hbool_t): herr_t;
    function H5Pget_preserve(plist_id: hid_t): Integer;
    function H5Pset_edc_check(plist_id: hid_t; check: H5Z_EDC_t): herr_t;
    function H5Pget_edc_check(plist_id: hid_t): H5Z_EDC_t;
    function H5Pset_filter_callback(plist_id: hid_t; func: H5Z_filter_func_t; op_data: Pointer): herr_t;
    function H5Pset_btree_ratios(plist_id: hid_t; left: double; middle: double; right: double): herr_t;
    function H5Pget_btree_ratios(plist_id: hid_t; left: Pdouble; middle: Pdouble; right: Pdouble): herr_t;
    function H5Pset_vlen_mem_manager(plist_id: hid_t; alloc_func: H5MM_allocate_t; alloc_info: Pointer; free_func: H5MM_free_t; free_info: Pointer): herr_t;
    function H5Pget_vlen_mem_manager(plist_id: hid_t; alloc_func: PH5MM_allocate_t; alloc_info: PPointer; free_func: PH5MM_free_t; free_info: PPointer): herr_t;
    function H5Pset_hyper_vector_size(fapl_id: hid_t; size: size_t): herr_t;
    function H5Pget_hyper_vector_size(fapl_id: hid_t; size: Psize_t): herr_t;
    function H5Pset_type_conv_cb(dxpl_id: hid_t; op: H5T_conv_except_func_t; operate_data: Pointer): herr_t;
    function H5Pget_type_conv_cb(dxpl_id: hid_t; op: PH5T_conv_except_func_t; operate_data: PPointer): herr_t;
    function H5Pset_create_intermediate_group(plist_id: hid_t; crt_intmd: Cardinal): herr_t;
    function H5Pget_create_intermediate_group(plist_id: hid_t; crt_intmd: PCardinal): herr_t;
    function H5Pset_local_heap_size_hint(plist_id: hid_t; size_hint: size_t): herr_t;
    function H5Pget_local_heap_size_hint(plist_id: hid_t; size_hint: Psize_t): herr_t;
    function H5Pset_link_phase_change(plist_id: hid_t; max_compact: Cardinal; min_dense: Cardinal): herr_t;
    function H5Pget_link_phase_change(plist_id: hid_t; max_compact: PCardinal; min_dense: PCardinal): herr_t;
    function H5Pset_est_link_info(plist_id: hid_t; est_num_entries: Cardinal; est_name_len: Cardinal): herr_t;
    function H5Pget_est_link_info(plist_id: hid_t; est_num_entries: PCardinal; est_name_len: PCardinal): herr_t;
    function H5Pset_link_creation_order(plist_id: hid_t; crt_order_flags: Cardinal): herr_t;
    function H5Pget_link_creation_order(plist_id: hid_t; crt_order_flags: PCardinal): herr_t;
    function H5Pset_char_encoding(plist_id: hid_t; encoding: H5T_cset_t): herr_t;
    function H5Pget_char_encoding(plist_id: hid_t; encoding: PH5T_cset_t): herr_t;
    function H5Pset_nlinks(plist_id: hid_t; nlinks: size_t): herr_t;
    function H5Pget_nlinks(plist_id: hid_t; nlinks: Psize_t): herr_t;
    function H5Pset_elink_prefix(plist_id: hid_t; prefix: PAnsiChar): herr_t;
    function H5Pget_elink_prefix(plist_id: hid_t; prefix: PAnsiChar; size: size_t): ssize_t;
    function H5Pget_elink_fapl(lapl_id: hid_t): hid_t;
    function H5Pset_elink_fapl(lapl_id: hid_t; fapl_id: hid_t): herr_t;
    function H5Pset_elink_acc_flags(lapl_id: hid_t; flags: Cardinal): herr_t;
    function H5Pget_elink_acc_flags(lapl_id: hid_t; flags: PCardinal): herr_t;
    function H5Pset_elink_cb(lapl_id: hid_t; func: H5L_elink_traverse_t; op_data: Pointer): herr_t;
    function H5Pget_elink_cb(lapl_id: hid_t; func: PH5L_elink_traverse_t; op_data: PPointer): herr_t;
    function H5Pset_copy_object(plist_id: hid_t; crt_intmd: Cardinal): herr_t;
    function H5Pget_copy_object(plist_id: hid_t; crt_intmd: PCardinal): herr_t;
    function H5Padd_merge_committed_dtype_path(plist_id: hid_t; path: PAnsiChar): herr_t;
    function H5Pfree_merge_committed_dtype_paths(plist_id: hid_t): herr_t;
    function H5Pset_mcdt_search_cb(plist_id: hid_t; func: H5O_mcdt_search_cb_t; op_data: Pointer): herr_t;
    function H5Pget_mcdt_search_cb(plist_id: hid_t; func: PH5O_mcdt_search_cb_t; op_data: PPointer): herr_t;
    property H5T_IEEE_F32BE: hid_t read FH5T_IEEE_F32BE;
    property H5T_IEEE_F32LE: hid_t read FH5T_IEEE_F32LE;
    property H5T_IEEE_F64BE: hid_t read FH5T_IEEE_F64BE;
    property H5T_IEEE_F64LE: hid_t read FH5T_IEEE_F64LE;
    property H5T_STD_I8BE: hid_t read FH5T_STD_I8BE;
    property H5T_STD_I8LE: hid_t read FH5T_STD_I8LE;
    property H5T_STD_I16BE: hid_t read FH5T_STD_I16BE;
    property H5T_STD_I16LE: hid_t read FH5T_STD_I16LE;
    property H5T_STD_I32BE: hid_t read FH5T_STD_I32BE;
    property H5T_STD_I32LE: hid_t read FH5T_STD_I32LE;
    property H5T_STD_I64BE: hid_t read FH5T_STD_I64BE;
    property H5T_STD_I64LE: hid_t read FH5T_STD_I64LE;
    property H5T_STD_U8BE: hid_t read FH5T_STD_U8BE;
    property H5T_STD_U8LE: hid_t read FH5T_STD_U8LE;
    property H5T_STD_U16BE: hid_t read FH5T_STD_U16BE;
    property H5T_STD_U16LE: hid_t read FH5T_STD_U16LE;
    property H5T_STD_U32BE: hid_t read FH5T_STD_U32BE;
    property H5T_STD_U32LE: hid_t read FH5T_STD_U32LE;
    property H5T_STD_U64BE: hid_t read FH5T_STD_U64BE;
    property H5T_STD_U64LE: hid_t read FH5T_STD_U64LE;
    property H5T_STD_B8BE: hid_t read FH5T_STD_B8BE;
    property H5T_STD_B8LE: hid_t read FH5T_STD_B8LE;
    property H5T_STD_B16BE: hid_t read FH5T_STD_B16BE;
    property H5T_STD_B16LE: hid_t read FH5T_STD_B16LE;
    property H5T_STD_B32BE: hid_t read FH5T_STD_B32BE;
    property H5T_STD_B32LE: hid_t read FH5T_STD_B32LE;
    property H5T_STD_B64BE: hid_t read FH5T_STD_B64BE;
    property H5T_STD_B64LE: hid_t read FH5T_STD_B64LE;
    property H5T_STD_REF_OBJ: hid_t read FH5T_STD_REF_OBJ;
    property H5T_STD_REF_DSETREG: hid_t read FH5T_STD_REF_DSETREG;
    property H5T_UNIX_D32BE: hid_t read FH5T_UNIX_D32BE;
    property H5T_UNIX_D32LE: hid_t read FH5T_UNIX_D32LE;
    property H5T_UNIX_D64BE: hid_t read FH5T_UNIX_D64BE;
    property H5T_UNIX_D64LE: hid_t read FH5T_UNIX_D64LE;
    property H5T_C_S1: hid_t read FH5T_C_S1;
    property H5T_FORTRAN_S1: hid_t read FH5T_FORTRAN_S1;
    property H5T_INTEL_I8: hid_t read FH5T_STD_I8LE;
    property H5T_INTEL_I16: hid_t read FH5T_STD_I16LE;
    property H5T_INTEL_I32: hid_t read FH5T_STD_I32LE;
    property H5T_INTEL_I64: hid_t read FH5T_STD_I64LE;
    property H5T_INTEL_U8: hid_t read FH5T_STD_U8LE;
    property H5T_INTEL_U16: hid_t read FH5T_STD_U16LE;
    property H5T_INTEL_U32: hid_t read FH5T_STD_U32LE;
    property H5T_INTEL_U64: hid_t read FH5T_STD_U64LE;
    property H5T_INTEL_B8: hid_t read FH5T_STD_B8LE;
    property H5T_INTEL_B16: hid_t read FH5T_STD_B16LE;
    property H5T_INTEL_B32: hid_t read FH5T_STD_B32LE;
    property H5T_INTEL_B64: hid_t read FH5T_STD_B64LE;
    property H5T_INTEL_F32: hid_t read FH5T_IEEE_F32LE;
    property H5T_INTEL_F64: hid_t read FH5T_IEEE_F64LE;
    property H5T_ALPHA_I8: hid_t read FH5T_STD_I8LE;
    property H5T_ALPHA_I16: hid_t read FH5T_STD_I16LE;
    property H5T_ALPHA_I32: hid_t read FH5T_STD_I32LE;
    property H5T_ALPHA_I64: hid_t read FH5T_STD_I64LE;
    property H5T_ALPHA_U8: hid_t read FH5T_STD_U8LE;
    property H5T_ALPHA_U16: hid_t read FH5T_STD_U16LE;
    property H5T_ALPHA_U32: hid_t read FH5T_STD_U32LE;
    property H5T_ALPHA_U64: hid_t read FH5T_STD_U64LE;
    property H5T_ALPHA_B8: hid_t read FH5T_STD_B8LE;
    property H5T_ALPHA_B16: hid_t read FH5T_STD_B16LE;
    property H5T_ALPHA_B32: hid_t read FH5T_STD_B32LE;
    property H5T_ALPHA_B64: hid_t read FH5T_STD_B64LE;
    property H5T_ALPHA_F32: hid_t read FH5T_IEEE_F32LE;
    property H5T_ALPHA_F64: hid_t read FH5T_IEEE_F64LE;
    property H5T_MIPS_I8: hid_t read FH5T_STD_I8BE;
    property H5T_MIPS_I16: hid_t read FH5T_STD_I16BE;
    property H5T_MIPS_I32: hid_t read FH5T_STD_I32BE;
    property H5T_MIPS_I64: hid_t read FH5T_STD_I64BE;
    property H5T_MIPS_U8: hid_t read FH5T_STD_U8BE;
    property H5T_MIPS_U16: hid_t read FH5T_STD_U16BE;
    property H5T_MIPS_U32: hid_t read FH5T_STD_U32BE;
    property H5T_MIPS_U64: hid_t read FH5T_STD_U64BE;
    property H5T_MIPS_B8: hid_t read FH5T_STD_B8BE;
    property H5T_MIPS_B16: hid_t read FH5T_STD_B16BE;
    property H5T_MIPS_B32: hid_t read FH5T_STD_B32BE;
    property H5T_MIPS_B64: hid_t read FH5T_STD_B64BE;
    property H5T_MIPS_F32: hid_t read FH5T_IEEE_F32BE;
    property H5T_MIPS_F64: hid_t read FH5T_IEEE_F64BE;
    property H5T_VAX_F32: hid_t read FH5T_VAX_F32;
    property H5T_VAX_F64: hid_t read FH5T_VAX_F64;
    property H5T_NATIVE_SCHAR: hid_t read FH5T_NATIVE_SCHAR;
    property H5T_NATIVE_UCHAR: hid_t read FH5T_NATIVE_UCHAR;
    property H5T_NATIVE_SHORT: hid_t read FH5T_NATIVE_SHORT;
    property H5T_NATIVE_USHORT: hid_t read FH5T_NATIVE_USHORT;
    property H5T_NATIVE_INT: hid_t read FH5T_NATIVE_INT;
    property H5T_NATIVE_UINT: hid_t read FH5T_NATIVE_UINT;
    property H5T_NATIVE_LONG: hid_t read FH5T_NATIVE_LONG;
    property H5T_NATIVE_ULONG: hid_t read FH5T_NATIVE_ULONG;
    property H5T_NATIVE_LLONG: hid_t read FH5T_NATIVE_LLONG;
    property H5T_NATIVE_ULLONG: hid_t read FH5T_NATIVE_ULLONG;
    property H5T_NATIVE_FLOAT: hid_t read FH5T_NATIVE_FLOAT;
    property H5T_NATIVE_DOUBLE: hid_t read FH5T_NATIVE_DOUBLE;
    property H5T_NATIVE_B8: hid_t read FH5T_NATIVE_B8;
    property H5T_NATIVE_B16: hid_t read FH5T_NATIVE_B16;
    property H5T_NATIVE_B32: hid_t read FH5T_NATIVE_B32;
    property H5T_NATIVE_B64: hid_t read FH5T_NATIVE_B64;
    property H5T_NATIVE_OPAQUE: hid_t read FH5T_NATIVE_OPAQUE;
    property H5T_NATIVE_HADDR: hid_t read FH5T_NATIVE_HADDR;
    property H5T_NATIVE_HSIZE: hid_t read FH5T_NATIVE_HSIZE;
    property H5T_NATIVE_HSSIZE: hid_t read FH5T_NATIVE_HSSIZE;
    property H5T_NATIVE_HERR: hid_t read FH5T_NATIVE_HERR;
    property H5T_NATIVE_HBOOL: hid_t read FH5T_NATIVE_HBOOL;
    property H5T_NATIVE_INT8: hid_t read FH5T_NATIVE_INT8;
    property H5T_NATIVE_UINT8: hid_t read FH5T_NATIVE_UINT8;
    property H5T_NATIVE_INT_LEAST8: hid_t read FH5T_NATIVE_INT_LEAST8;
    property H5T_NATIVE_UINT_LEAST8: hid_t read FH5T_NATIVE_UINT_LEAST8;
    property H5T_NATIVE_INT_FAST8: hid_t read FH5T_NATIVE_INT_FAST8;
    property H5T_NATIVE_UINT_FAST8: hid_t read FH5T_NATIVE_UINT_FAST8;
    property H5T_NATIVE_INT16: hid_t read FH5T_NATIVE_INT16;
    property H5T_NATIVE_UINT16: hid_t read FH5T_NATIVE_UINT16;
    property H5T_NATIVE_INT_LEAST16: hid_t read FH5T_NATIVE_INT_LEAST16;
    property H5T_NATIVE_UINT_LEAST16: hid_t read FH5T_NATIVE_UINT_LEAST16;
    property H5T_NATIVE_INT_FAST16: hid_t read FH5T_NATIVE_INT_FAST16;
    property H5T_NATIVE_UINT_FAST16: hid_t read FH5T_NATIVE_UINT_FAST16;
    property H5T_NATIVE_INT32: hid_t read FH5T_NATIVE_INT32;
    property H5T_NATIVE_UINT32: hid_t read FH5T_NATIVE_UINT32;
    property H5T_NATIVE_INT_LEAST32: hid_t read FH5T_NATIVE_INT_LEAST32;
    property H5T_NATIVE_UINT_LEAST32: hid_t read FH5T_NATIVE_UINT_LEAST32;
    property H5T_NATIVE_INT_FAST32: hid_t read FH5T_NATIVE_INT_FAST32;
    property H5T_NATIVE_UINT_FAST32: hid_t read FH5T_NATIVE_UINT_FAST32;
    property H5T_NATIVE_INT64: hid_t read FH5T_NATIVE_INT64;
    property H5T_NATIVE_UINT64: hid_t read FH5T_NATIVE_UINT64;
    property H5T_NATIVE_INT_LEAST64: hid_t read FH5T_NATIVE_INT_LEAST64;
    property H5T_NATIVE_UINT_LEAST64: hid_t read FH5T_NATIVE_UINT_LEAST64;
    property H5T_NATIVE_INT_FAST64: hid_t read FH5T_NATIVE_INT_FAST64;
    property H5T_NATIVE_UINT_FAST64: hid_t read FH5T_NATIVE_UINT_FAST64;
    property H5E_ERR_CLS: hid_t read FH5E_ERR_CLS;
    property H5P_ROOT: hid_t read FH5P_CLS_ROOT_ID;
    property H5P_OBJECT_CREATE: hid_t read FH5P_CLS_OBJECT_CREATE_ID;
    property H5P_FILE_CREATE: hid_t read FH5P_CLS_FILE_CREATE_ID;
    property H5P_FILE_ACCESS: hid_t read FH5P_CLS_FILE_ACCESS_ID;
    property H5P_DATASET_CREATE: hid_t read FH5P_CLS_DATASET_CREATE_ID;
    property H5P_DATASET_ACCESS: hid_t read FH5P_CLS_DATASET_ACCESS_ID;
    property H5P_DATASET_XFER: hid_t read FH5P_CLS_DATASET_XFER_ID;
    property H5P_FILE_MOUNT: hid_t read FH5P_CLS_FILE_MOUNT_ID;
    property H5P_GROUP_CREATE: hid_t read FH5P_CLS_GROUP_CREATE_ID;
    property H5P_GROUP_ACCESS: hid_t read FH5P_CLS_GROUP_ACCESS_ID;
    property H5P_DATATYPE_CREATE: hid_t read FH5P_CLS_DATATYPE_CREATE_ID;
    property H5P_DATATYPE_ACCESS: hid_t read FH5P_CLS_DATATYPE_ACCESS_ID;
    property H5P_STRING_CREATE: hid_t read FH5P_CLS_STRING_CREATE_ID;
    property H5P_ATTRIBUTE_CREATE: hid_t read FH5P_CLS_ATTRIBUTE_CREATE_ID;
    property H5P_OBJECT_COPY: hid_t read FH5P_CLS_OBJECT_COPY_ID;
    property H5P_LINK_CREATE: hid_t read FH5P_CLS_LINK_CREATE_ID;
    property H5P_LINK_ACCESS: hid_t read FH5P_CLS_LINK_ACCESS_ID;
    property H5P_FILE_CREATE_DEFAULT: hid_t read FH5P_LST_FILE_CREATE_ID;
    property H5P_FILE_ACCESS_DEFAULT: hid_t read FH5P_LST_FILE_ACCESS_ID;
    property H5P_DATASET_CREATE_DEFAULT: hid_t read FH5P_LST_DATASET_CREATE_ID;
    property H5P_DATASET_ACCESS_DEFAULT: hid_t read FH5P_LST_DATASET_ACCESS_ID;
    property H5P_DATASET_XFER_DEFAULT: hid_t read FH5P_LST_DATASET_XFER_ID;
    property H5P_FILE_MOUNT_DEFAULT: hid_t read FH5P_LST_FILE_MOUNT_ID;
    property H5P_GROUP_CREATE_DEFAULT: hid_t read FH5P_LST_GROUP_CREATE_ID;
    property H5P_GROUP_ACCESS_DEFAULT: hid_t read FH5P_LST_GROUP_ACCESS_ID;
    property H5P_DATATYPE_CREATE_DEFAULT: hid_t read FH5P_LST_DATATYPE_CREATE_ID;
    property H5P_DATATYPE_ACCESS_DEFAULT: hid_t read FH5P_LST_DATATYPE_ACCESS_ID;
    property H5P_ATTRIBUTE_CREATE_DEFAULT: hid_t read FH5P_LST_ATTRIBUTE_CREATE_ID;
    property H5P_OBJECT_COPY_DEFAULT: hid_t read FH5P_LST_OBJECT_COPY_ID;
    property H5P_LINK_CREATE_DEFAULT: hid_t read FH5P_LST_LINK_CREATE_ID;
    property H5P_LINK_ACCESS_DEFAULT: hid_t read FH5P_LST_LINK_ACCESS_ID;

    property Handle: THandle read FHandle;
    function IsValid: Boolean;
  end;

implementation

constructor THDF5Dll.Create(APath: string);

  function GetDllProc(AModule: THandle; AName: string): Pointer;
  begin
    Result := GetProcAddress(AModule, PChar(AName));
    Assert(Assigned(Result));
  end;

begin
  inherited Create;
  FHandle := LoadLibrary(PChar(APath));

  @FH5open := GetDllProc(FHandle, 'H5open');
  @FH5close := GetDllProc(FHandle, 'H5close');
  @FH5dont_atexit := GetDllProc(FHandle, 'H5dont_atexit');
  @FH5garbage_collect := GetDllProc(FHandle, 'H5garbage_collect');
  @FH5set_free_list_limits := GetDllProc(FHandle, 'H5set_free_list_limits');
  @FH5get_libversion := GetDllProc(FHandle, 'H5get_libversion');
  @FH5check_version := GetDllProc(FHandle, 'H5check_version');
  @FH5free_memory := GetDllProc(FHandle, 'H5free_memory');
  @FH5Iregister := GetDllProc(FHandle, 'H5Iregister');
  @FH5Iobject_verify := GetDllProc(FHandle, 'H5Iobject_verify');
  @FH5Iremove_verify := GetDllProc(FHandle, 'H5Iremove_verify');
  @FH5Iget_type := GetDllProc(FHandle, 'H5Iget_type');
  @FH5Iget_file_id := GetDllProc(FHandle, 'H5Iget_file_id');
  @FH5Iget_name := GetDllProc(FHandle, 'H5Iget_name');
  @FH5Iinc_ref := GetDllProc(FHandle, 'H5Iinc_ref');
  @FH5Idec_ref := GetDllProc(FHandle, 'H5Idec_ref');
  @FH5Iget_ref := GetDllProc(FHandle, 'H5Iget_ref');
  @FH5Iregister_type := GetDllProc(FHandle, 'H5Iregister_type');
  @FH5Iclear_type := GetDllProc(FHandle, 'H5Iclear_type');
  @FH5Idestroy_type := GetDllProc(FHandle, 'H5Idestroy_type');
  @FH5Iinc_type_ref := GetDllProc(FHandle, 'H5Iinc_type_ref');
  @FH5Idec_type_ref := GetDllProc(FHandle, 'H5Idec_type_ref');
  @FH5Iget_type_ref := GetDllProc(FHandle, 'H5Iget_type_ref');
  @FH5Isearch := GetDllProc(FHandle, 'H5Isearch');
  @FH5Inmembers := GetDllProc(FHandle, 'H5Inmembers');
  @FH5Itype_exists := GetDllProc(FHandle, 'H5Itype_exists');
  @FH5Iis_valid := GetDllProc(FHandle, 'H5Iis_valid');
  @FH5Zregister := GetDllProc(FHandle, 'H5Zregister');
  @FH5Zunregister := GetDllProc(FHandle, 'H5Zunregister');
  @FH5Zfilter_avail := GetDllProc(FHandle, 'H5Zfilter_avail');
  @FH5Zget_filter_info := GetDllProc(FHandle, 'H5Zget_filter_info');
  @FH5Tcreate := GetDllProc(FHandle, 'H5Tcreate');
  @FH5Tcopy := GetDllProc(FHandle, 'H5Tcopy');
  @FH5Tclose := GetDllProc(FHandle, 'H5Tclose');
  @FH5Tequal := GetDllProc(FHandle, 'H5Tequal');
  @FH5Tlock := GetDllProc(FHandle, 'H5Tlock');
  @FH5Tcommit2 := GetDllProc(FHandle, 'H5Tcommit2');
  @FH5Topen2 := GetDllProc(FHandle, 'H5Topen2');
  @FH5Tcommit_anon := GetDllProc(FHandle, 'H5Tcommit_anon');
  @FH5Tget_create_plist := GetDllProc(FHandle, 'H5Tget_create_plist');
  @FH5Tcommitted := GetDllProc(FHandle, 'H5Tcommitted');
  @FH5Tencode := GetDllProc(FHandle, 'H5Tencode');
  @FH5Tdecode := GetDllProc(FHandle, 'H5Tdecode');
  @FH5Tinsert := GetDllProc(FHandle, 'H5Tinsert');
  @FH5Tpack := GetDllProc(FHandle, 'H5Tpack');
  @FH5Tenum_create := GetDllProc(FHandle, 'H5Tenum_create');
  @FH5Tenum_insert := GetDllProc(FHandle, 'H5Tenum_insert');
  @FH5Tenum_nameof := GetDllProc(FHandle, 'H5Tenum_nameof');
  @FH5Tenum_valueof := GetDllProc(FHandle, 'H5Tenum_valueof');
  @FH5Tvlen_create := GetDllProc(FHandle, 'H5Tvlen_create');
  @FH5Tarray_create2 := GetDllProc(FHandle, 'H5Tarray_create2');
  @FH5Tget_array_ndims := GetDllProc(FHandle, 'H5Tget_array_ndims');
  @FH5Tget_array_dims2 := GetDllProc(FHandle, 'H5Tget_array_dims2');
  @FH5Tset_tag := GetDllProc(FHandle, 'H5Tset_tag');
  @FH5Tget_tag := GetDllProc(FHandle, 'H5Tget_tag');
  @FH5Tget_super := GetDllProc(FHandle, 'H5Tget_super');
  @FH5Tget_class := GetDllProc(FHandle, 'H5Tget_class');
  @FH5Tdetect_class := GetDllProc(FHandle, 'H5Tdetect_class');
  @FH5Tget_size := GetDllProc(FHandle, 'H5Tget_size');
  @FH5Tget_order := GetDllProc(FHandle, 'H5Tget_order');
  @FH5Tget_precision := GetDllProc(FHandle, 'H5Tget_precision');
  @FH5Tget_offset := GetDllProc(FHandle, 'H5Tget_offset');
  @FH5Tget_pad := GetDllProc(FHandle, 'H5Tget_pad');
  @FH5Tget_sign := GetDllProc(FHandle, 'H5Tget_sign');
  @FH5Tget_fields := GetDllProc(FHandle, 'H5Tget_fields');
  @FH5Tget_ebias := GetDllProc(FHandle, 'H5Tget_ebias');
  @FH5Tget_norm := GetDllProc(FHandle, 'H5Tget_norm');
  @FH5Tget_inpad := GetDllProc(FHandle, 'H5Tget_inpad');
  @FH5Tget_strpad := GetDllProc(FHandle, 'H5Tget_strpad');
  @FH5Tget_nmembers := GetDllProc(FHandle, 'H5Tget_nmembers');
  @FH5Tget_member_name := GetDllProc(FHandle, 'H5Tget_member_name');
  @FH5Tget_member_index := GetDllProc(FHandle, 'H5Tget_member_index');
  @FH5Tget_member_offset := GetDllProc(FHandle, 'H5Tget_member_offset');
  @FH5Tget_member_class := GetDllProc(FHandle, 'H5Tget_member_class');
  @FH5Tget_member_type := GetDllProc(FHandle, 'H5Tget_member_type');
  @FH5Tget_member_value := GetDllProc(FHandle, 'H5Tget_member_value');
  @FH5Tget_cset := GetDllProc(FHandle, 'H5Tget_cset');
  @FH5Tis_variable_str := GetDllProc(FHandle, 'H5Tis_variable_str');
  @FH5Tget_native_type := GetDllProc(FHandle, 'H5Tget_native_type');
  @FH5Tset_size := GetDllProc(FHandle, 'H5Tset_size');
  @FH5Tset_order := GetDllProc(FHandle, 'H5Tset_order');
  @FH5Tset_precision := GetDllProc(FHandle, 'H5Tset_precision');
  @FH5Tset_offset := GetDllProc(FHandle, 'H5Tset_offset');
  @FH5Tset_pad := GetDllProc(FHandle, 'H5Tset_pad');
  @FH5Tset_sign := GetDllProc(FHandle, 'H5Tset_sign');
  @FH5Tset_fields := GetDllProc(FHandle, 'H5Tset_fields');
  @FH5Tset_ebias := GetDllProc(FHandle, 'H5Tset_ebias');
  @FH5Tset_norm := GetDllProc(FHandle, 'H5Tset_norm');
  @FH5Tset_inpad := GetDllProc(FHandle, 'H5Tset_inpad');
  @FH5Tset_cset := GetDllProc(FHandle, 'H5Tset_cset');
  @FH5Tset_strpad := GetDllProc(FHandle, 'H5Tset_strpad');
  @FH5Tregister := GetDllProc(FHandle, 'H5Tregister');
  @FH5Tunregister := GetDllProc(FHandle, 'H5Tunregister');
  @FH5Tfind := GetDllProc(FHandle, 'H5Tfind');
  @FH5Tcompiler_conv := GetDllProc(FHandle, 'H5Tcompiler_conv');
  @FH5Tconvert := GetDllProc(FHandle, 'H5Tconvert');
  @FH5Dcreate2 := GetDllProc(FHandle, 'H5Dcreate2');
  @FH5Dcreate_anon := GetDllProc(FHandle, 'H5Dcreate_anon');
  @FH5Dopen2 := GetDllProc(FHandle, 'H5Dopen2');
  @FH5Dclose := GetDllProc(FHandle, 'H5Dclose');
  @FH5Dget_space := GetDllProc(FHandle, 'H5Dget_space');
  @FH5Dget_space_status := GetDllProc(FHandle, 'H5Dget_space_status');
  @FH5Dget_type := GetDllProc(FHandle, 'H5Dget_type');
  @FH5Dget_create_plist := GetDllProc(FHandle, 'H5Dget_create_plist');
  @FH5Dget_access_plist := GetDllProc(FHandle, 'H5Dget_access_plist');
  @FH5Dget_storage_size := GetDllProc(FHandle, 'H5Dget_storage_size');
  @FH5Dget_offset := GetDllProc(FHandle, 'H5Dget_offset');
  @FH5Dread := GetDllProc(FHandle, 'H5Dread');
  @FH5Dwrite := GetDllProc(FHandle, 'H5Dwrite');
  @FH5Diterate := GetDllProc(FHandle, 'H5Diterate');
  @FH5Dvlen_reclaim := GetDllProc(FHandle, 'H5Dvlen_reclaim');
  @FH5Dvlen_get_buf_size := GetDllProc(FHandle, 'H5Dvlen_get_buf_size');
  @FH5Dfill := GetDllProc(FHandle, 'H5Dfill');
  @FH5Dset_extent := GetDllProc(FHandle, 'H5Dset_extent');
  @FH5Dscatter := GetDllProc(FHandle, 'H5Dscatter');
  @FH5Dgather := GetDllProc(FHandle, 'H5Dgather');
  @FH5Ddebug := GetDllProc(FHandle, 'H5Ddebug');
  @FH5Eregister_class := GetDllProc(FHandle, 'H5Eregister_class');
  @FH5Eunregister_class := GetDllProc(FHandle, 'H5Eunregister_class');
  @FH5Eclose_msg := GetDllProc(FHandle, 'H5Eclose_msg');
  @FH5Ecreate_msg := GetDllProc(FHandle, 'H5Ecreate_msg');
  @FH5Ecreate_stack := GetDllProc(FHandle, 'H5Ecreate_stack');
  @FH5Eget_current_stack := GetDllProc(FHandle, 'H5Eget_current_stack');
  @FH5Eclose_stack := GetDllProc(FHandle, 'H5Eclose_stack');
  @FH5Eget_class_name := GetDllProc(FHandle, 'H5Eget_class_name');
  @FH5Eset_current_stack := GetDllProc(FHandle, 'H5Eset_current_stack');
  @FH5Epop := GetDllProc(FHandle, 'H5Epop');
  @FH5Eprint2 := GetDllProc(FHandle, 'H5Eprint2');
  @FH5Ewalk2 := GetDllProc(FHandle, 'H5Ewalk2');
  @FH5Eget_auto2 := GetDllProc(FHandle, 'H5Eget_auto2');
  @FH5Eset_auto2 := GetDllProc(FHandle, 'H5Eset_auto2');
  @FH5Eclear2 := GetDllProc(FHandle, 'H5Eclear2');
  @FH5Eauto_is_v2 := GetDllProc(FHandle, 'H5Eauto_is_v2');
  @FH5Eget_msg := GetDllProc(FHandle, 'H5Eget_msg');
  @FH5Eget_num := GetDllProc(FHandle, 'H5Eget_num');
  @FH5Screate := GetDllProc(FHandle, 'H5Screate');
  @FH5Screate_simple := GetDllProc(FHandle, 'H5Screate_simple');
  @FH5Sset_extent_simple := GetDllProc(FHandle, 'H5Sset_extent_simple');
  @FH5Scopy := GetDllProc(FHandle, 'H5Scopy');
  @FH5Sclose := GetDllProc(FHandle, 'H5Sclose');
  @FH5Sencode := GetDllProc(FHandle, 'H5Sencode');
  @FH5Sdecode := GetDllProc(FHandle, 'H5Sdecode');
  @FH5Sget_simple_extent_npoints := GetDllProc(FHandle, 'H5Sget_simple_extent_npoints');
  @FH5Sget_simple_extent_ndims := GetDllProc(FHandle, 'H5Sget_simple_extent_ndims');
  @FH5Sget_simple_extent_dims := GetDllProc(FHandle, 'H5Sget_simple_extent_dims');
  @FH5Sis_simple := GetDllProc(FHandle, 'H5Sis_simple');
  @FH5Sget_select_npoints := GetDllProc(FHandle, 'H5Sget_select_npoints');
  @FH5Sselect_hyperslab := GetDllProc(FHandle, 'H5Sselect_hyperslab');
  @FH5Sselect_elements := GetDllProc(FHandle, 'H5Sselect_elements');
  @FH5Sget_simple_extent_type := GetDllProc(FHandle, 'H5Sget_simple_extent_type');
  @FH5Sset_extent_none := GetDllProc(FHandle, 'H5Sset_extent_none');
  @FH5Sextent_copy := GetDllProc(FHandle, 'H5Sextent_copy');
  @FH5Sextent_equal := GetDllProc(FHandle, 'H5Sextent_equal');
  @FH5Sselect_all := GetDllProc(FHandle, 'H5Sselect_all');
  @FH5Sselect_none := GetDllProc(FHandle, 'H5Sselect_none');
  @FH5Soffset_simple := GetDllProc(FHandle, 'H5Soffset_simple');
  @FH5Sselect_valid := GetDllProc(FHandle, 'H5Sselect_valid');
  @FH5Sget_select_hyper_nblocks := GetDllProc(FHandle, 'H5Sget_select_hyper_nblocks');
  @FH5Sget_select_elem_npoints := GetDllProc(FHandle, 'H5Sget_select_elem_npoints');
  @FH5Sget_select_hyper_blocklist := GetDllProc(FHandle, 'H5Sget_select_hyper_blocklist');
  @FH5Sget_select_elem_pointlist := GetDllProc(FHandle, 'H5Sget_select_elem_pointlist');
  @FH5Sget_select_bounds := GetDllProc(FHandle, 'H5Sget_select_bounds');
  @FH5Sget_select_type := GetDllProc(FHandle, 'H5Sget_select_type');
  @FH5Lmove := GetDllProc(FHandle, 'H5Lmove');
  @FH5Lcopy := GetDllProc(FHandle, 'H5Lcopy');
  @FH5Lcreate_hard := GetDllProc(FHandle, 'H5Lcreate_hard');
  @FH5Lcreate_soft := GetDllProc(FHandle, 'H5Lcreate_soft');
  @FH5Ldelete := GetDllProc(FHandle, 'H5Ldelete');
  @FH5Ldelete_by_idx := GetDllProc(FHandle, 'H5Ldelete_by_idx');
  @FH5Lget_val := GetDllProc(FHandle, 'H5Lget_val');
  @FH5Lget_val_by_idx := GetDllProc(FHandle, 'H5Lget_val_by_idx');
  @FH5Lexists := GetDllProc(FHandle, 'H5Lexists');
  @FH5Lget_info := GetDllProc(FHandle, 'H5Lget_info');
  @FH5Lget_info_by_idx := GetDllProc(FHandle, 'H5Lget_info_by_idx');
  @FH5Lget_name_by_idx := GetDllProc(FHandle, 'H5Lget_name_by_idx');
  @FH5Literate := GetDllProc(FHandle, 'H5Literate');
  @FH5Literate_by_name := GetDllProc(FHandle, 'H5Literate_by_name');
  @FH5Lvisit := GetDllProc(FHandle, 'H5Lvisit');
  @FH5Lvisit_by_name := GetDllProc(FHandle, 'H5Lvisit_by_name');
  @FH5Lcreate_ud := GetDllProc(FHandle, 'H5Lcreate_ud');
  @FH5Lregister := GetDllProc(FHandle, 'H5Lregister');
  @FH5Lunregister := GetDllProc(FHandle, 'H5Lunregister');
  @FH5Lis_registered := GetDllProc(FHandle, 'H5Lis_registered');
  @FH5Lunpack_elink_val := GetDllProc(FHandle, 'H5Lunpack_elink_val');
  @FH5Lcreate_external := GetDllProc(FHandle, 'H5Lcreate_external');
  @FH5Oopen := GetDllProc(FHandle, 'H5Oopen');
  @FH5Oopen_by_addr := GetDllProc(FHandle, 'H5Oopen_by_addr');
  @FH5Oopen_by_idx := GetDllProc(FHandle, 'H5Oopen_by_idx');
  @FH5Oexists_by_name := GetDllProc(FHandle, 'H5Oexists_by_name');
  @FH5Oget_info := GetDllProc(FHandle, 'H5Oget_info');
  @FH5Oget_info_by_name := GetDllProc(FHandle, 'H5Oget_info_by_name');
  @FH5Oget_info_by_idx := GetDllProc(FHandle, 'H5Oget_info_by_idx');
  @FH5Olink := GetDllProc(FHandle, 'H5Olink');
  @FH5Oincr_refcount := GetDllProc(FHandle, 'H5Oincr_refcount');
  @FH5Odecr_refcount := GetDllProc(FHandle, 'H5Odecr_refcount');
  @FH5Ocopy := GetDllProc(FHandle, 'H5Ocopy');
  @FH5Oset_comment := GetDllProc(FHandle, 'H5Oset_comment');
  @FH5Oset_comment_by_name := GetDllProc(FHandle, 'H5Oset_comment_by_name');
  @FH5Oget_comment := GetDllProc(FHandle, 'H5Oget_comment');
  @FH5Oget_comment_by_name := GetDllProc(FHandle, 'H5Oget_comment_by_name');
  @FH5Ovisit := GetDllProc(FHandle, 'H5Ovisit');
  @FH5Ovisit_by_name := GetDllProc(FHandle, 'H5Ovisit_by_name');
  @FH5Oclose := GetDllProc(FHandle, 'H5Oclose');
  @FH5Fis_hdf5 := GetDllProc(FHandle, 'H5Fis_hdf5');
  @FH5Fcreate := GetDllProc(FHandle, 'H5Fcreate');
  @FH5Fopen := GetDllProc(FHandle, 'H5Fopen');
  @FH5Freopen := GetDllProc(FHandle, 'H5Freopen');
  @FH5Fflush := GetDllProc(FHandle, 'H5Fflush');
  @FH5Fclose := GetDllProc(FHandle, 'H5Fclose');
  @FH5Fget_create_plist := GetDllProc(FHandle, 'H5Fget_create_plist');
  @FH5Fget_access_plist := GetDllProc(FHandle, 'H5Fget_access_plist');
  @FH5Fget_intent := GetDllProc(FHandle, 'H5Fget_intent');
  @FH5Fget_obj_count := GetDllProc(FHandle, 'H5Fget_obj_count');
  @FH5Fget_obj_ids := GetDllProc(FHandle, 'H5Fget_obj_ids');
  @FH5Fget_vfd_handle := GetDllProc(FHandle, 'H5Fget_vfd_handle');
  @FH5Fmount := GetDllProc(FHandle, 'H5Fmount');
  @FH5Funmount := GetDllProc(FHandle, 'H5Funmount');
  @FH5Fget_freespace := GetDllProc(FHandle, 'H5Fget_freespace');
  @FH5Fget_filesize := GetDllProc(FHandle, 'H5Fget_filesize');
  @FH5Fget_file_image := GetDllProc(FHandle, 'H5Fget_file_image');
  @FH5Fget_mdc_config := GetDllProc(FHandle, 'H5Fget_mdc_config');
  @FH5Fset_mdc_config := GetDllProc(FHandle, 'H5Fset_mdc_config');
  @FH5Fget_mdc_hit_rate := GetDllProc(FHandle, 'H5Fget_mdc_hit_rate');
  @FH5Fget_mdc_size := GetDllProc(FHandle, 'H5Fget_mdc_size');
  @FH5Freset_mdc_hit_rate_stats := GetDllProc(FHandle, 'H5Freset_mdc_hit_rate_stats');
  @FH5Fget_name := GetDllProc(FHandle, 'H5Fget_name');
  @FH5Fget_info := GetDllProc(FHandle, 'H5Fget_info');
  @FH5Fclear_elink_file_cache := GetDllProc(FHandle, 'H5Fclear_elink_file_cache');
  @FH5Acreate2 := GetDllProc(FHandle, 'H5Acreate2');
  @FH5Acreate_by_name := GetDllProc(FHandle, 'H5Acreate_by_name');
  @FH5Aopen := GetDllProc(FHandle, 'H5Aopen');
  @FH5Aopen_by_name := GetDllProc(FHandle, 'H5Aopen_by_name');
  @FH5Aopen_by_idx := GetDllProc(FHandle, 'H5Aopen_by_idx');
  @FH5Awrite := GetDllProc(FHandle, 'H5Awrite');
  @FH5Aread := GetDllProc(FHandle, 'H5Aread');
  @FH5Aclose := GetDllProc(FHandle, 'H5Aclose');
  @FH5Aget_space := GetDllProc(FHandle, 'H5Aget_space');
  @FH5Aget_type := GetDllProc(FHandle, 'H5Aget_type');
  @FH5Aget_create_plist := GetDllProc(FHandle, 'H5Aget_create_plist');
  @FH5Aget_name := GetDllProc(FHandle, 'H5Aget_name');
  @FH5Aget_name_by_idx := GetDllProc(FHandle, 'H5Aget_name_by_idx');
  @FH5Aget_storage_size := GetDllProc(FHandle, 'H5Aget_storage_size');
  @FH5Aget_info := GetDllProc(FHandle, 'H5Aget_info');
  @FH5Aget_info_by_name := GetDllProc(FHandle, 'H5Aget_info_by_name');
  @FH5Aget_info_by_idx := GetDllProc(FHandle, 'H5Aget_info_by_idx');
  @FH5Arename := GetDllProc(FHandle, 'H5Arename');
  @FH5Arename_by_name := GetDllProc(FHandle, 'H5Arename_by_name');
  @FH5Aiterate2 := GetDllProc(FHandle, 'H5Aiterate2');
  @FH5Aiterate_by_name := GetDllProc(FHandle, 'H5Aiterate_by_name');
  @FH5Adelete := GetDllProc(FHandle, 'H5Adelete');
  @FH5Adelete_by_name := GetDllProc(FHandle, 'H5Adelete_by_name');
  @FH5Adelete_by_idx := GetDllProc(FHandle, 'H5Adelete_by_idx');
  @FH5Aexists := GetDllProc(FHandle, 'H5Aexists');
  @FH5Aexists_by_name := GetDllProc(FHandle, 'H5Aexists_by_name');
  @FH5FDregister := GetDllProc(FHandle, 'H5FDregister');
  @FH5FDunregister := GetDllProc(FHandle, 'H5FDunregister');
  @FH5FDopen := GetDllProc(FHandle, 'H5FDopen');
  @FH5FDclose := GetDllProc(FHandle, 'H5FDclose');
  @FH5FDcmp := GetDllProc(FHandle, 'H5FDcmp');
  @FH5FDquery := GetDllProc(FHandle, 'H5FDquery');
  @FH5FDalloc := GetDllProc(FHandle, 'H5FDalloc');
  @FH5FDfree := GetDllProc(FHandle, 'H5FDfree');
  @FH5FDget_eoa := GetDllProc(FHandle, 'H5FDget_eoa');
  @FH5FDset_eoa := GetDllProc(FHandle, 'H5FDset_eoa');
  @FH5FDget_eof := GetDllProc(FHandle, 'H5FDget_eof');
  @FH5FDget_vfd_handle := GetDllProc(FHandle, 'H5FDget_vfd_handle');
  @FH5FDread := GetDllProc(FHandle, 'H5FDread');
  @FH5FDwrite := GetDllProc(FHandle, 'H5FDwrite');
  @FH5FDflush := GetDllProc(FHandle, 'H5FDflush');
  @FH5FDtruncate := GetDllProc(FHandle, 'H5FDtruncate');
  @FH5Gcreate2 := GetDllProc(FHandle, 'H5Gcreate2');
  @FH5Gcreate_anon := GetDllProc(FHandle, 'H5Gcreate_anon');
  @FH5Gopen2 := GetDllProc(FHandle, 'H5Gopen2');
  @FH5Gget_create_plist := GetDllProc(FHandle, 'H5Gget_create_plist');
  @FH5Gget_info := GetDllProc(FHandle, 'H5Gget_info');
  @FH5Gget_info_by_name := GetDllProc(FHandle, 'H5Gget_info_by_name');
  @FH5Gget_info_by_idx := GetDllProc(FHandle, 'H5Gget_info_by_idx');
  @FH5Gclose := GetDllProc(FHandle, 'H5Gclose');
  @FH5Rcreate := GetDllProc(FHandle, 'H5Rcreate');
  @FH5Rdereference := GetDllProc(FHandle, 'H5Rdereference');
  @FH5Rget_region := GetDllProc(FHandle, 'H5Rget_region');
  @FH5Rget_obj_type2 := GetDllProc(FHandle, 'H5Rget_obj_type2');
  @FH5Rget_name := GetDllProc(FHandle, 'H5Rget_name');
  @FH5Pcreate_class := GetDllProc(FHandle, 'H5Pcreate_class');
  @FH5Pget_class_name := GetDllProc(FHandle, 'H5Pget_class_name');
  @FH5Pcreate := GetDllProc(FHandle, 'H5Pcreate');
  @FH5Pregister2 := GetDllProc(FHandle, 'H5Pregister2');
  @FH5Pinsert2 := GetDllProc(FHandle, 'H5Pinsert2');
  @FH5Pset := GetDllProc(FHandle, 'H5Pset');
  @FH5Pexist := GetDllProc(FHandle, 'H5Pexist');
  @FH5Pget_size := GetDllProc(FHandle, 'H5Pget_size');
  @FH5Pget_nprops := GetDllProc(FHandle, 'H5Pget_nprops');
  @FH5Pget_class := GetDllProc(FHandle, 'H5Pget_class');
  @FH5Pget_class_parent := GetDllProc(FHandle, 'H5Pget_class_parent');
  @FH5Pget := GetDllProc(FHandle, 'H5Pget');
  @FH5Pequal := GetDllProc(FHandle, 'H5Pequal');
  @FH5Pisa_class := GetDllProc(FHandle, 'H5Pisa_class');
  @FH5Piterate := GetDllProc(FHandle, 'H5Piterate');
  @FH5Pcopy_prop := GetDllProc(FHandle, 'H5Pcopy_prop');
  @FH5Premove := GetDllProc(FHandle, 'H5Premove');
  @FH5Punregister := GetDllProc(FHandle, 'H5Punregister');
  @FH5Pclose_class := GetDllProc(FHandle, 'H5Pclose_class');
  @FH5Pclose := GetDllProc(FHandle, 'H5Pclose');
  @FH5Pcopy := GetDllProc(FHandle, 'H5Pcopy');
  @FH5Pset_attr_phase_change := GetDllProc(FHandle, 'H5Pset_attr_phase_change');
  @FH5Pget_attr_phase_change := GetDllProc(FHandle, 'H5Pget_attr_phase_change');
  @FH5Pset_attr_creation_order := GetDllProc(FHandle, 'H5Pset_attr_creation_order');
  @FH5Pget_attr_creation_order := GetDllProc(FHandle, 'H5Pget_attr_creation_order');
  @FH5Pset_obj_track_times := GetDllProc(FHandle, 'H5Pset_obj_track_times');
  @FH5Pget_obj_track_times := GetDllProc(FHandle, 'H5Pget_obj_track_times');
  @FH5Pmodify_filter := GetDllProc(FHandle, 'H5Pmodify_filter');
  @FH5Pset_filter := GetDllProc(FHandle, 'H5Pset_filter');
  @FH5Pget_nfilters := GetDllProc(FHandle, 'H5Pget_nfilters');
  @FH5Pget_filter2 := GetDllProc(FHandle, 'H5Pget_filter2');
  @FH5Pget_filter_by_id2 := GetDllProc(FHandle, 'H5Pget_filter_by_id2');
  @FH5Pall_filters_avail := GetDllProc(FHandle, 'H5Pall_filters_avail');
  @FH5Premove_filter := GetDllProc(FHandle, 'H5Premove_filter');
  @FH5Pset_deflate := GetDllProc(FHandle, 'H5Pset_deflate');
  @FH5Pset_fletcher32 := GetDllProc(FHandle, 'H5Pset_fletcher32');
  @FH5Pget_version := GetDllProc(FHandle, 'H5Pget_version');
  @FH5Pset_userblock := GetDllProc(FHandle, 'H5Pset_userblock');
  @FH5Pget_userblock := GetDllProc(FHandle, 'H5Pget_userblock');
  @FH5Pset_sizes := GetDllProc(FHandle, 'H5Pset_sizes');
  @FH5Pget_sizes := GetDllProc(FHandle, 'H5Pget_sizes');
  @FH5Pset_sym_k := GetDllProc(FHandle, 'H5Pset_sym_k');
  @FH5Pget_sym_k := GetDllProc(FHandle, 'H5Pget_sym_k');
  @FH5Pset_istore_k := GetDllProc(FHandle, 'H5Pset_istore_k');
  @FH5Pget_istore_k := GetDllProc(FHandle, 'H5Pget_istore_k');
  @FH5Pset_shared_mesg_nindexes := GetDllProc(FHandle, 'H5Pset_shared_mesg_nindexes');
  @FH5Pget_shared_mesg_nindexes := GetDllProc(FHandle, 'H5Pget_shared_mesg_nindexes');
  @FH5Pset_shared_mesg_index := GetDllProc(FHandle, 'H5Pset_shared_mesg_index');
  @FH5Pget_shared_mesg_index := GetDllProc(FHandle, 'H5Pget_shared_mesg_index');
  @FH5Pset_shared_mesg_phase_change := GetDllProc(FHandle, 'H5Pset_shared_mesg_phase_change');
  @FH5Pget_shared_mesg_phase_change := GetDllProc(FHandle, 'H5Pget_shared_mesg_phase_change');
  @FH5Pset_alignment := GetDllProc(FHandle, 'H5Pset_alignment');
  @FH5Pget_alignment := GetDllProc(FHandle, 'H5Pget_alignment');
  @FH5Pset_driver := GetDllProc(FHandle, 'H5Pset_driver');
  @FH5Pget_driver := GetDllProc(FHandle, 'H5Pget_driver');
  @FH5Pget_driver_info := GetDllProc(FHandle, 'H5Pget_driver_info');
  @FH5Pset_family_offset := GetDllProc(FHandle, 'H5Pset_family_offset');
  @FH5Pget_family_offset := GetDllProc(FHandle, 'H5Pget_family_offset');
  @FH5Pset_multi_type := GetDllProc(FHandle, 'H5Pset_multi_type');
  @FH5Pget_multi_type := GetDllProc(FHandle, 'H5Pget_multi_type');
  @FH5Pset_cache := GetDllProc(FHandle, 'H5Pset_cache');
  @FH5Pget_cache := GetDllProc(FHandle, 'H5Pget_cache');
  @FH5Pset_mdc_config := GetDllProc(FHandle, 'H5Pset_mdc_config');
  @FH5Pget_mdc_config := GetDllProc(FHandle, 'H5Pget_mdc_config');
  @FH5Pset_gc_references := GetDllProc(FHandle, 'H5Pset_gc_references');
  @FH5Pget_gc_references := GetDllProc(FHandle, 'H5Pget_gc_references');
  @FH5Pset_fclose_degree := GetDllProc(FHandle, 'H5Pset_fclose_degree');
  @FH5Pget_fclose_degree := GetDllProc(FHandle, 'H5Pget_fclose_degree');
  @FH5Pset_meta_block_size := GetDllProc(FHandle, 'H5Pset_meta_block_size');
  @FH5Pget_meta_block_size := GetDllProc(FHandle, 'H5Pget_meta_block_size');
  @FH5Pset_sieve_buf_size := GetDllProc(FHandle, 'H5Pset_sieve_buf_size');
  @FH5Pget_sieve_buf_size := GetDllProc(FHandle, 'H5Pget_sieve_buf_size');
  @FH5Pset_small_data_block_size := GetDllProc(FHandle, 'H5Pset_small_data_block_size');
  @FH5Pget_small_data_block_size := GetDllProc(FHandle, 'H5Pget_small_data_block_size');
  @FH5Pset_libver_bounds := GetDllProc(FHandle, 'H5Pset_libver_bounds');
  @FH5Pget_libver_bounds := GetDllProc(FHandle, 'H5Pget_libver_bounds');
  @FH5Pset_elink_file_cache_size := GetDllProc(FHandle, 'H5Pset_elink_file_cache_size');
  @FH5Pget_elink_file_cache_size := GetDllProc(FHandle, 'H5Pget_elink_file_cache_size');
  @FH5Pset_file_image := GetDllProc(FHandle, 'H5Pset_file_image');
  @FH5Pget_file_image := GetDllProc(FHandle, 'H5Pget_file_image');
  @FH5Pset_file_image_callbacks := GetDllProc(FHandle, 'H5Pset_file_image_callbacks');
  @FH5Pget_file_image_callbacks := GetDllProc(FHandle, 'H5Pget_file_image_callbacks');
  @FH5Pset_core_write_tracking := GetDllProc(FHandle, 'H5Pset_core_write_tracking');
  @FH5Pget_core_write_tracking := GetDllProc(FHandle, 'H5Pget_core_write_tracking');
  @FH5Pset_layout := GetDllProc(FHandle, 'H5Pset_layout');
  @FH5Pget_layout := GetDllProc(FHandle, 'H5Pget_layout');
  @FH5Pset_chunk := GetDllProc(FHandle, 'H5Pset_chunk');
  @FH5Pget_chunk := GetDllProc(FHandle, 'H5Pget_chunk');
  @FH5Pset_external := GetDllProc(FHandle, 'H5Pset_external');
  @FH5Pget_external_count := GetDllProc(FHandle, 'H5Pget_external_count');
  @FH5Pget_external := GetDllProc(FHandle, 'H5Pget_external');
  @FH5Pset_szip := GetDllProc(FHandle, 'H5Pset_szip');
  @FH5Pset_shuffle := GetDllProc(FHandle, 'H5Pset_shuffle');
  @FH5Pset_nbit := GetDllProc(FHandle, 'H5Pset_nbit');
  @FH5Pset_scaleoffset := GetDllProc(FHandle, 'H5Pset_scaleoffset');
  @FH5Pset_fill_value := GetDllProc(FHandle, 'H5Pset_fill_value');
  @FH5Pget_fill_value := GetDllProc(FHandle, 'H5Pget_fill_value');
  @FH5Pfill_value_defined := GetDllProc(FHandle, 'H5Pfill_value_defined');
  @FH5Pset_alloc_time := GetDllProc(FHandle, 'H5Pset_alloc_time');
  @FH5Pget_alloc_time := GetDllProc(FHandle, 'H5Pget_alloc_time');
  @FH5Pset_fill_time := GetDllProc(FHandle, 'H5Pset_fill_time');
  @FH5Pget_fill_time := GetDllProc(FHandle, 'H5Pget_fill_time');
  @FH5Pset_chunk_cache := GetDllProc(FHandle, 'H5Pset_chunk_cache');
  @FH5Pget_chunk_cache := GetDllProc(FHandle, 'H5Pget_chunk_cache');
  @FH5Pset_data_transform := GetDllProc(FHandle, 'H5Pset_data_transform');
  @FH5Pget_data_transform := GetDllProc(FHandle, 'H5Pget_data_transform');
  @FH5Pset_buffer := GetDllProc(FHandle, 'H5Pset_buffer');
  @FH5Pget_buffer := GetDllProc(FHandle, 'H5Pget_buffer');
  @FH5Pset_preserve := GetDllProc(FHandle, 'H5Pset_preserve');
  @FH5Pget_preserve := GetDllProc(FHandle, 'H5Pget_preserve');
  @FH5Pset_edc_check := GetDllProc(FHandle, 'H5Pset_edc_check');
  @FH5Pget_edc_check := GetDllProc(FHandle, 'H5Pget_edc_check');
  @FH5Pset_filter_callback := GetDllProc(FHandle, 'H5Pset_filter_callback');
  @FH5Pset_btree_ratios := GetDllProc(FHandle, 'H5Pset_btree_ratios');
  @FH5Pget_btree_ratios := GetDllProc(FHandle, 'H5Pget_btree_ratios');
  @FH5Pset_vlen_mem_manager := GetDllProc(FHandle, 'H5Pset_vlen_mem_manager');
  @FH5Pget_vlen_mem_manager := GetDllProc(FHandle, 'H5Pget_vlen_mem_manager');
  @FH5Pset_hyper_vector_size := GetDllProc(FHandle, 'H5Pset_hyper_vector_size');
  @FH5Pget_hyper_vector_size := GetDllProc(FHandle, 'H5Pget_hyper_vector_size');
  @FH5Pset_type_conv_cb := GetDllProc(FHandle, 'H5Pset_type_conv_cb');
  @FH5Pget_type_conv_cb := GetDllProc(FHandle, 'H5Pget_type_conv_cb');
  @FH5Pset_create_intermediate_group := GetDllProc(FHandle, 'H5Pset_create_intermediate_group');
  @FH5Pget_create_intermediate_group := GetDllProc(FHandle, 'H5Pget_create_intermediate_group');
  @FH5Pset_local_heap_size_hint := GetDllProc(FHandle, 'H5Pset_local_heap_size_hint');
  @FH5Pget_local_heap_size_hint := GetDllProc(FHandle, 'H5Pget_local_heap_size_hint');
  @FH5Pset_link_phase_change := GetDllProc(FHandle, 'H5Pset_link_phase_change');
  @FH5Pget_link_phase_change := GetDllProc(FHandle, 'H5Pget_link_phase_change');
  @FH5Pset_est_link_info := GetDllProc(FHandle, 'H5Pset_est_link_info');
  @FH5Pget_est_link_info := GetDllProc(FHandle, 'H5Pget_est_link_info');
  @FH5Pset_link_creation_order := GetDllProc(FHandle, 'H5Pset_link_creation_order');
  @FH5Pget_link_creation_order := GetDllProc(FHandle, 'H5Pget_link_creation_order');
  @FH5Pset_char_encoding := GetDllProc(FHandle, 'H5Pset_char_encoding');
  @FH5Pget_char_encoding := GetDllProc(FHandle, 'H5Pget_char_encoding');
  @FH5Pset_nlinks := GetDllProc(FHandle, 'H5Pset_nlinks');
  @FH5Pget_nlinks := GetDllProc(FHandle, 'H5Pget_nlinks');
  @FH5Pset_elink_prefix := GetDllProc(FHandle, 'H5Pset_elink_prefix');
  @FH5Pget_elink_prefix := GetDllProc(FHandle, 'H5Pget_elink_prefix');
  @FH5Pget_elink_fapl := GetDllProc(FHandle, 'H5Pget_elink_fapl');
  @FH5Pset_elink_fapl := GetDllProc(FHandle, 'H5Pset_elink_fapl');
  @FH5Pset_elink_acc_flags := GetDllProc(FHandle, 'H5Pset_elink_acc_flags');
  @FH5Pget_elink_acc_flags := GetDllProc(FHandle, 'H5Pget_elink_acc_flags');
  @FH5Pset_elink_cb := GetDllProc(FHandle, 'H5Pset_elink_cb');
  @FH5Pget_elink_cb := GetDllProc(FHandle, 'H5Pget_elink_cb');
  @FH5Pset_copy_object := GetDllProc(FHandle, 'H5Pset_copy_object');
  @FH5Pget_copy_object := GetDllProc(FHandle, 'H5Pget_copy_object');
  @FH5Padd_merge_committed_dtype_path := GetDllProc(FHandle, 'H5Padd_merge_committed_dtype_path');
  @FH5Pfree_merge_committed_dtype_paths := GetDllProc(FHandle, 'H5Pfree_merge_committed_dtype_paths');
  @FH5Pset_mcdt_search_cb := GetDllProc(FHandle, 'H5Pset_mcdt_search_cb');
  @FH5Pget_mcdt_search_cb := GetDllProc(FHandle, 'H5Pget_mcdt_search_cb');

  H5open;
  FH5T_IEEE_F32BE := Phid_t(GetDllProc(FHandle, 'H5T_IEEE_F32BE_g'))^;
  FH5T_IEEE_F32LE := Phid_t(GetDllProc(FHandle, 'H5T_IEEE_F32LE_g'))^;
  FH5T_IEEE_F64BE := Phid_t(GetDllProc(FHandle, 'H5T_IEEE_F64BE_g'))^;
  FH5T_IEEE_F64LE := Phid_t(GetDllProc(FHandle, 'H5T_IEEE_F64LE_g'))^;
  FH5T_STD_I8BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_I8BE_g'))^;
  FH5T_STD_I8LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_I8LE_g'))^;
  FH5T_STD_I16BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_I16BE_g'))^;
  FH5T_STD_I16LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_I16LE_g'))^;
  FH5T_STD_I32BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_I32BE_g'))^;
  FH5T_STD_I32LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_I32LE_g'))^;
  FH5T_STD_I64BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_I64BE_g'))^;
  FH5T_STD_I64LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_I64LE_g'))^;
  FH5T_STD_U8BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_U8BE_g'))^;
  FH5T_STD_U8LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_U8LE_g'))^;
  FH5T_STD_U16BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_U16BE_g'))^;
  FH5T_STD_U16LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_U16LE_g'))^;
  FH5T_STD_U32BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_U32BE_g'))^;
  FH5T_STD_U32LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_U32LE_g'))^;
  FH5T_STD_U64BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_U64BE_g'))^;
  FH5T_STD_U64LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_U64LE_g'))^;
  FH5T_STD_B8BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_B8BE_g'))^;
  FH5T_STD_B8LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_B8LE_g'))^;
  FH5T_STD_B16BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_B16BE_g'))^;
  FH5T_STD_B16LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_B16LE_g'))^;
  FH5T_STD_B32BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_B32BE_g'))^;
  FH5T_STD_B32LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_B32LE_g'))^;
  FH5T_STD_B64BE := Phid_t(GetDllProc(FHandle, 'H5T_STD_B64BE_g'))^;
  FH5T_STD_B64LE := Phid_t(GetDllProc(FHandle, 'H5T_STD_B64LE_g'))^;
  FH5T_STD_REF_OBJ := Phid_t(GetDllProc(FHandle, 'H5T_STD_REF_OBJ_g'))^;
  FH5T_STD_REF_DSETREG := Phid_t(GetDllProc(FHandle, 'H5T_STD_REF_DSETREG_g'))^;
  FH5T_UNIX_D32BE := Phid_t(GetDllProc(FHandle, 'H5T_UNIX_D32BE_g'))^;
  FH5T_UNIX_D32LE := Phid_t(GetDllProc(FHandle, 'H5T_UNIX_D32LE_g'))^;
  FH5T_UNIX_D64BE := Phid_t(GetDllProc(FHandle, 'H5T_UNIX_D64BE_g'))^;
  FH5T_UNIX_D64LE := Phid_t(GetDllProc(FHandle, 'H5T_UNIX_D64LE_g'))^;
  FH5T_C_S1 := Phid_t(GetDllProc(FHandle, 'H5T_C_S1_g'))^;
  FH5T_FORTRAN_S1 := Phid_t(GetDllProc(FHandle, 'H5T_FORTRAN_S1_g'))^;
  FH5T_VAX_F32 := Phid_t(GetDllProc(FHandle, 'H5T_VAX_F32_g'))^;
  FH5T_VAX_F64 := Phid_t(GetDllProc(FHandle, 'H5T_VAX_F64_g'))^;
  FH5T_NATIVE_SCHAR := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_SCHAR_g'))^;
  FH5T_NATIVE_UCHAR := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UCHAR_g'))^;
  FH5T_NATIVE_SHORT := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_SHORT_g'))^;
  FH5T_NATIVE_USHORT := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_USHORT_g'))^;
  FH5T_NATIVE_INT := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT_g'))^;
  FH5T_NATIVE_UINT := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT_g'))^;
  FH5T_NATIVE_LONG := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_LONG_g'))^;
  FH5T_NATIVE_ULONG := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_ULONG_g'))^;
  FH5T_NATIVE_LLONG := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_LLONG_g'))^;
  FH5T_NATIVE_ULLONG := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_ULLONG_g'))^;
  FH5T_NATIVE_FLOAT := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_FLOAT_g'))^;
  FH5T_NATIVE_DOUBLE := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_DOUBLE_g'))^;
  FH5T_NATIVE_B8 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_B8_g'))^;
  FH5T_NATIVE_B16 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_B16_g'))^;
  FH5T_NATIVE_B32 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_B32_g'))^;
  FH5T_NATIVE_B64 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_B64_g'))^;
  FH5T_NATIVE_OPAQUE := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_OPAQUE_g'))^;
  FH5T_NATIVE_HADDR := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_HADDR_g'))^;
  FH5T_NATIVE_HSIZE := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_HSIZE_g'))^;
  FH5T_NATIVE_HSSIZE := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_HSSIZE_g'))^;
  FH5T_NATIVE_HERR := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_HERR_g'))^;
  FH5T_NATIVE_HBOOL := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_HBOOL_g'))^;
  FH5T_NATIVE_INT8 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT8_g'))^;
  FH5T_NATIVE_UINT8 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT8_g'))^;
  FH5T_NATIVE_INT_LEAST8 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT_LEAST8_g'))^;
  FH5T_NATIVE_UINT_LEAST8 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT_LEAST8_g'))^;
  FH5T_NATIVE_INT_FAST8 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT_FAST8_g'))^;
  FH5T_NATIVE_UINT_FAST8 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT_FAST8_g'))^;
  FH5T_NATIVE_INT16 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT16_g'))^;
  FH5T_NATIVE_UINT16 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT16_g'))^;
  FH5T_NATIVE_INT_LEAST16 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT_LEAST16_g'))^;
  FH5T_NATIVE_UINT_LEAST16 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT_LEAST16_g'))^;
  FH5T_NATIVE_INT_FAST16 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT_FAST16_g'))^;
  FH5T_NATIVE_UINT_FAST16 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT_FAST16_g'))^;
  FH5T_NATIVE_INT32 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT32_g'))^;
  FH5T_NATIVE_UINT32 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT32_g'))^;
  FH5T_NATIVE_INT_LEAST32 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT_LEAST32_g'))^;
  FH5T_NATIVE_UINT_LEAST32 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT_LEAST32_g'))^;
  FH5T_NATIVE_INT_FAST32 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT_FAST32_g'))^;
  FH5T_NATIVE_UINT_FAST32 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT_FAST32_g'))^;
  FH5T_NATIVE_INT64 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT64_g'))^;
  FH5T_NATIVE_UINT64 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT64_g'))^;
  FH5T_NATIVE_INT_LEAST64 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT_LEAST64_g'))^;
  FH5T_NATIVE_UINT_LEAST64 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT_LEAST64_g'))^;
  FH5T_NATIVE_INT_FAST64 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_INT_FAST64_g'))^;
  FH5T_NATIVE_UINT_FAST64 := Phid_t(GetDllProc(FHandle, 'H5T_NATIVE_UINT_FAST64_g'))^;
  FH5E_ERR_CLS := Phid_t(GetDllProc(FHandle, 'H5E_ERR_CLS_g'))^;
  FH5P_CLS_ROOT_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_ROOT_ID_g'))^;
  FH5P_CLS_OBJECT_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_OBJECT_CREATE_ID_g'))^;
  FH5P_CLS_FILE_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_FILE_CREATE_ID_g'))^;
  FH5P_CLS_FILE_ACCESS_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_FILE_ACCESS_ID_g'))^;
  FH5P_CLS_DATASET_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_DATASET_CREATE_ID_g'))^;
  FH5P_CLS_DATASET_ACCESS_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_DATASET_ACCESS_ID_g'))^;
  FH5P_CLS_DATASET_XFER_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_DATASET_XFER_ID_g'))^;
  FH5P_CLS_FILE_MOUNT_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_FILE_MOUNT_ID_g'))^;
  FH5P_CLS_GROUP_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_GROUP_CREATE_ID_g'))^;
  FH5P_CLS_GROUP_ACCESS_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_GROUP_ACCESS_ID_g'))^;
  FH5P_CLS_DATATYPE_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_DATATYPE_CREATE_ID_g'))^;
  FH5P_CLS_DATATYPE_ACCESS_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_DATATYPE_ACCESS_ID_g'))^;
  FH5P_CLS_STRING_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_STRING_CREATE_ID_g'))^;
  FH5P_CLS_ATTRIBUTE_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_ATTRIBUTE_CREATE_ID_g'))^;
  FH5P_CLS_OBJECT_COPY_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_OBJECT_COPY_ID_g'))^;
  FH5P_CLS_LINK_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_LINK_CREATE_ID_g'))^;
  FH5P_CLS_LINK_ACCESS_ID := Phid_t(GetDllProc(FHandle, 'H5P_CLS_LINK_ACCESS_ID_g'))^;
  FH5P_LST_FILE_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_FILE_CREATE_ID_g'))^;
  FH5P_LST_FILE_ACCESS_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_FILE_ACCESS_ID_g'))^;
  FH5P_LST_DATASET_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_DATASET_CREATE_ID_g'))^;
  FH5P_LST_DATASET_ACCESS_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_DATASET_ACCESS_ID_g'))^;
  FH5P_LST_DATASET_XFER_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_DATASET_XFER_ID_g'))^;
  FH5P_LST_FILE_MOUNT_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_FILE_MOUNT_ID_g'))^;
  FH5P_LST_GROUP_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_GROUP_CREATE_ID_g'))^;
  FH5P_LST_GROUP_ACCESS_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_GROUP_ACCESS_ID_g'))^;
  FH5P_LST_DATATYPE_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_DATATYPE_CREATE_ID_g'))^;
  FH5P_LST_DATATYPE_ACCESS_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_DATATYPE_ACCESS_ID_g'))^;
  FH5P_LST_ATTRIBUTE_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_ATTRIBUTE_CREATE_ID_g'))^;
  FH5P_LST_OBJECT_COPY_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_OBJECT_COPY_ID_g'))^;
  FH5P_LST_LINK_CREATE_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_LINK_CREATE_ID_g'))^;
  FH5P_LST_LINK_ACCESS_ID := Phid_t(GetDllProc(FHandle, 'H5P_LST_LINK_ACCESS_ID_g'))^;
end;

destructor THDF5Dll.Destroy;
begin
  if FHandle <> 0 then
    FreeLibrary(FHandle);
  inherited;
end;

function THDF5Dll.IsValid: Boolean;
begin
  Result := (FHandle <> 0);
end;

function THDF5Dll.H5open: herr_t;
begin
  Result := FH5open();
end;

function THDF5Dll.H5close: herr_t;
begin
  Result := FH5close();
end;

function THDF5Dll.H5dont_atexit: herr_t;
begin
  Result := FH5dont_atexit();
end;

function THDF5Dll.H5garbage_collect: herr_t;
begin
  Result := FH5garbage_collect();
end;

function THDF5Dll.H5set_free_list_limits(reg_global_lim: Integer; reg_list_lim: Integer; arr_global_lim: Integer; arr_list_lim: Integer; blk_global_lim: Integer; blk_list_lim: Integer): herr_t;
begin
  Result := FH5set_free_list_limits(reg_global_lim, reg_list_lim, arr_global_lim, arr_list_lim, blk_global_lim, blk_list_lim);
end;

function THDF5Dll.H5get_libversion(majnum: PCardinal; minnum: PCardinal; relnum: PCardinal): herr_t;
begin
  Result := FH5get_libversion(majnum, minnum, relnum);
end;

function THDF5Dll.H5check_version(majnum: Cardinal; minnum: Cardinal; relnum: Cardinal): herr_t;
begin
  Result := FH5check_version(majnum, minnum, relnum);
end;

function THDF5Dll.H5free_memory(mem: Pointer): herr_t;
begin
  Result := FH5free_memory(mem);
end;

function THDF5Dll.H5Iregister(typ: H5I_type_t; obj: Pointer): hid_t;
begin
  Result := FH5Iregister(typ, obj);
end;

function THDF5Dll.H5Iobject_verify(id: hid_t; id_type: H5I_type_t): Pointer;
begin
  Result := FH5Iobject_verify(id, id_type);
end;

function THDF5Dll.H5Iremove_verify(id: hid_t; id_type: H5I_type_t): Pointer;
begin
  Result := FH5Iremove_verify(id, id_type);
end;

function THDF5Dll.H5Iget_type(id: hid_t): H5I_type_t;
begin
  Result := FH5Iget_type(id);
end;

function THDF5Dll.H5Iget_file_id(id: hid_t): hid_t;
begin
  Result := FH5Iget_file_id(id);
end;

function THDF5Dll.H5Iget_name(id: hid_t; name: PAnsiChar; size: size_t): ssize_t;
begin
  Result := FH5Iget_name(id, name, size);
end;

function THDF5Dll.H5Iinc_ref(id: hid_t): Integer;
begin
  Result := FH5Iinc_ref(id);
end;

function THDF5Dll.H5Idec_ref(id: hid_t): Integer;
begin
  Result := FH5Idec_ref(id);
end;

function THDF5Dll.H5Iget_ref(id: hid_t): Integer;
begin
  Result := FH5Iget_ref(id);
end;

function THDF5Dll.H5Iregister_type(hash_size: size_t; reserved: Cardinal; free_func: H5I_free_t): H5I_type_t;
begin
  Result := FH5Iregister_type(hash_size, reserved, free_func);
end;

function THDF5Dll.H5Iclear_type(typ: H5I_type_t; force: hbool_t): herr_t;
begin
  Result := FH5Iclear_type(typ, force);
end;

function THDF5Dll.H5Idestroy_type(typ: H5I_type_t): herr_t;
begin
  Result := FH5Idestroy_type(typ);
end;

function THDF5Dll.H5Iinc_type_ref(typ: H5I_type_t): Integer;
begin
  Result := FH5Iinc_type_ref(typ);
end;

function THDF5Dll.H5Idec_type_ref(typ: H5I_type_t): Integer;
begin
  Result := FH5Idec_type_ref(typ);
end;

function THDF5Dll.H5Iget_type_ref(typ: H5I_type_t): Integer;
begin
  Result := FH5Iget_type_ref(typ);
end;

function THDF5Dll.H5Isearch(typ: H5I_type_t; func: H5I_search_func_t; key: Pointer): Pointer;
begin
  Result := FH5Isearch(typ, func, key);
end;

function THDF5Dll.H5Inmembers(typ: H5I_type_t; num_members: Phsize_t): herr_t;
begin
  Result := FH5Inmembers(typ, num_members);
end;

function THDF5Dll.H5Itype_exists(typ: H5I_type_t): htri_t;
begin
  Result := FH5Itype_exists(typ);
end;

function THDF5Dll.H5Iis_valid(id: hid_t): htri_t;
begin
  Result := FH5Iis_valid(id);
end;

function THDF5Dll.H5Zregister(cls: Pointer): herr_t;
begin
  Result := FH5Zregister(cls);
end;

function THDF5Dll.H5Zunregister(id: H5Z_filter_t): herr_t;
begin
  Result := FH5Zunregister(id);
end;

function THDF5Dll.H5Zfilter_avail(id: H5Z_filter_t): htri_t;
begin
  Result := FH5Zfilter_avail(id);
end;

function THDF5Dll.H5Zget_filter_info(filter: H5Z_filter_t; filter_config_flags: PCardinal): herr_t;
begin
  Result := FH5Zget_filter_info(filter, filter_config_flags);
end;

function THDF5Dll.H5Tcreate(typ: H5T_class_t; size: size_t): hid_t;
begin
  Result := FH5Tcreate(typ, size);
end;

function THDF5Dll.H5Tcopy(type_id: hid_t): hid_t;
begin
  Result := FH5Tcopy(type_id);
end;

function THDF5Dll.H5Tclose(type_id: hid_t): herr_t;
begin
  Result := FH5Tclose(type_id);
end;

function THDF5Dll.H5Tequal(type1_id: hid_t; type2_id: hid_t): htri_t;
begin
  Result := FH5Tequal(type1_id, type2_id);
end;

function THDF5Dll.H5Tlock(type_id: hid_t): herr_t;
begin
  Result := FH5Tlock(type_id);
end;

function THDF5Dll.H5Tcommit2(loc_id: hid_t; name: PAnsiChar; type_id: hid_t; lcpl_id: hid_t; tcpl_id: hid_t; tapl_id: hid_t): herr_t;
begin
  Result := FH5Tcommit2(loc_id, name, type_id, lcpl_id, tcpl_id, tapl_id);
end;

function THDF5Dll.H5Topen2(loc_id: hid_t; name: PAnsiChar; tapl_id: hid_t): hid_t;
begin
  Result := FH5Topen2(loc_id, name, tapl_id);
end;

function THDF5Dll.H5Tcommit_anon(loc_id: hid_t; type_id: hid_t; tcpl_id: hid_t; tapl_id: hid_t): herr_t;
begin
  Result := FH5Tcommit_anon(loc_id, type_id, tcpl_id, tapl_id);
end;

function THDF5Dll.H5Tget_create_plist(type_id: hid_t): hid_t;
begin
  Result := FH5Tget_create_plist(type_id);
end;

function THDF5Dll.H5Tcommitted(type_id: hid_t): htri_t;
begin
  Result := FH5Tcommitted(type_id);
end;

function THDF5Dll.H5Tencode(obj_id: hid_t; buf: Pointer; nalloc: Psize_t): herr_t;
begin
  Result := FH5Tencode(obj_id, buf, nalloc);
end;

function THDF5Dll.H5Tdecode(buf: Pointer): hid_t;
begin
  Result := FH5Tdecode(buf);
end;

function THDF5Dll.H5Tinsert(parent_id: hid_t; name: PAnsiChar; offset: size_t; member_id: hid_t): herr_t;
begin
  Result := FH5Tinsert(parent_id, name, offset, member_id);
end;

function THDF5Dll.H5Tpack(type_id: hid_t): herr_t;
begin
  Result := FH5Tpack(type_id);
end;

function THDF5Dll.H5Tenum_create(base_id: hid_t): hid_t;
begin
  Result := FH5Tenum_create(base_id);
end;

function THDF5Dll.H5Tenum_insert(typ: hid_t; name: PAnsiChar; value: Pointer): herr_t;
begin
  Result := FH5Tenum_insert(typ, name, value);
end;

function THDF5Dll.H5Tenum_nameof(typ: hid_t; value: Pointer; name: PAnsiChar; size: size_t): herr_t;
begin
  Result := FH5Tenum_nameof(typ, value, name, size);
end;

function THDF5Dll.H5Tenum_valueof(typ: hid_t; name: PAnsiChar; value: Pointer): herr_t;
begin
  Result := FH5Tenum_valueof(typ, name, value);
end;

function THDF5Dll.H5Tvlen_create(base_id: hid_t): hid_t;
begin
  Result := FH5Tvlen_create(base_id);
end;

function THDF5Dll.H5Tarray_create2(base_id: hid_t; ndims: Cardinal; dim: Phsize_t): hid_t;
begin
  Result := FH5Tarray_create2(base_id, ndims, dim);
end;

function THDF5Dll.H5Tget_array_ndims(type_id: hid_t): Integer;
begin
  Result := FH5Tget_array_ndims(type_id);
end;

function THDF5Dll.H5Tget_array_dims2(type_id: hid_t; dims: Phsize_t): Integer;
begin
  Result := FH5Tget_array_dims2(type_id, dims);
end;

function THDF5Dll.H5Tset_tag(typ: hid_t; tag: PAnsiChar): herr_t;
begin
  Result := FH5Tset_tag(typ, tag);
end;

function THDF5Dll.H5Tget_tag(typ: hid_t): PAnsiChar;
begin
  Result := FH5Tget_tag(typ);
end;

function THDF5Dll.H5Tget_super(typ: hid_t): hid_t;
begin
  Result := FH5Tget_super(typ);
end;

function THDF5Dll.H5Tget_class(type_id: hid_t): H5T_class_t;
begin
  Result := FH5Tget_class(type_id);
end;

function THDF5Dll.H5Tdetect_class(type_id: hid_t; cls: H5T_class_t): htri_t;
begin
  Result := FH5Tdetect_class(type_id, cls);
end;

function THDF5Dll.H5Tget_size(type_id: hid_t): size_t;
begin
  Result := FH5Tget_size(type_id);
end;

function THDF5Dll.H5Tget_order(type_id: hid_t): H5T_order_t;
begin
  Result := FH5Tget_order(type_id);
end;

function THDF5Dll.H5Tget_precision(type_id: hid_t): size_t;
begin
  Result := FH5Tget_precision(type_id);
end;

function THDF5Dll.H5Tget_offset(type_id: hid_t): Integer;
begin
  Result := FH5Tget_offset(type_id);
end;

function THDF5Dll.H5Tget_pad(type_id: hid_t; lsb: PH5T_pad_t; msb: PH5T_pad_t): herr_t;
begin
  Result := FH5Tget_pad(type_id, lsb, msb);
end;

function THDF5Dll.H5Tget_sign(type_id: hid_t): H5T_sign_t;
begin
  Result := FH5Tget_sign(type_id);
end;

function THDF5Dll.H5Tget_fields(type_id: hid_t; spos: Psize_t; epos: Psize_t; esize: Psize_t; mpos: Psize_t; msize: Psize_t): herr_t;
begin
  Result := FH5Tget_fields(type_id, spos, epos, esize, mpos, msize);
end;

function THDF5Dll.H5Tget_ebias(type_id: hid_t): size_t;
begin
  Result := FH5Tget_ebias(type_id);
end;

function THDF5Dll.H5Tget_norm(type_id: hid_t): H5T_norm_t;
begin
  Result := FH5Tget_norm(type_id);
end;

function THDF5Dll.H5Tget_inpad(type_id: hid_t): H5T_pad_t;
begin
  Result := FH5Tget_inpad(type_id);
end;

function THDF5Dll.H5Tget_strpad(type_id: hid_t): H5T_str_t;
begin
  Result := FH5Tget_strpad(type_id);
end;

function THDF5Dll.H5Tget_nmembers(type_id: hid_t): Integer;
begin
  Result := FH5Tget_nmembers(type_id);
end;

function THDF5Dll.H5Tget_member_name(type_id: hid_t; membno: Cardinal): PAnsiChar;
begin
  Result := FH5Tget_member_name(type_id, membno);
end;

function THDF5Dll.H5Tget_member_index(type_id: hid_t; name: PAnsiChar): Integer;
begin
  Result := FH5Tget_member_index(type_id, name);
end;

function THDF5Dll.H5Tget_member_offset(type_id: hid_t; membno: Cardinal): size_t;
begin
  Result := FH5Tget_member_offset(type_id, membno);
end;

function THDF5Dll.H5Tget_member_class(type_id: hid_t; membno: Cardinal): H5T_class_t;
begin
  Result := FH5Tget_member_class(type_id, membno);
end;

function THDF5Dll.H5Tget_member_type(type_id: hid_t; membno: Cardinal): hid_t;
begin
  Result := FH5Tget_member_type(type_id, membno);
end;

function THDF5Dll.H5Tget_member_value(type_id: hid_t; membno: Cardinal; value: Pointer): herr_t;
begin
  Result := FH5Tget_member_value(type_id, membno, value);
end;

function THDF5Dll.H5Tget_cset(type_id: hid_t): H5T_cset_t;
begin
  Result := FH5Tget_cset(type_id);
end;

function THDF5Dll.H5Tis_variable_str(type_id: hid_t): htri_t;
begin
  Result := FH5Tis_variable_str(type_id);
end;

function THDF5Dll.H5Tget_native_type(type_id: hid_t; direction: H5T_direction_t): hid_t;
begin
  Result := FH5Tget_native_type(type_id, direction);
end;

function THDF5Dll.H5Tset_size(type_id: hid_t; size: size_t): herr_t;
begin
  Result := FH5Tset_size(type_id, size);
end;

function THDF5Dll.H5Tset_order(type_id: hid_t; order: H5T_order_t): herr_t;
begin
  Result := FH5Tset_order(type_id, order);
end;

function THDF5Dll.H5Tset_precision(type_id: hid_t; prec: size_t): herr_t;
begin
  Result := FH5Tset_precision(type_id, prec);
end;

function THDF5Dll.H5Tset_offset(type_id: hid_t; offset: size_t): herr_t;
begin
  Result := FH5Tset_offset(type_id, offset);
end;

function THDF5Dll.H5Tset_pad(type_id: hid_t; lsb: H5T_pad_t; msb: H5T_pad_t): herr_t;
begin
  Result := FH5Tset_pad(type_id, lsb, msb);
end;

function THDF5Dll.H5Tset_sign(type_id: hid_t; sign: H5T_sign_t): herr_t;
begin
  Result := FH5Tset_sign(type_id, sign);
end;

function THDF5Dll.H5Tset_fields(type_id: hid_t; spos: size_t; epos: size_t; esize: size_t; mpos: size_t; msize: size_t): herr_t;
begin
  Result := FH5Tset_fields(type_id, spos, epos, esize, mpos, msize);
end;

function THDF5Dll.H5Tset_ebias(type_id: hid_t; ebias: size_t): herr_t;
begin
  Result := FH5Tset_ebias(type_id, ebias);
end;

function THDF5Dll.H5Tset_norm(type_id: hid_t; norm: H5T_norm_t): herr_t;
begin
  Result := FH5Tset_norm(type_id, norm);
end;

function THDF5Dll.H5Tset_inpad(type_id: hid_t; pad: H5T_pad_t): herr_t;
begin
  Result := FH5Tset_inpad(type_id, pad);
end;

function THDF5Dll.H5Tset_cset(type_id: hid_t; cset: H5T_cset_t): herr_t;
begin
  Result := FH5Tset_cset(type_id, cset);
end;

function THDF5Dll.H5Tset_strpad(type_id: hid_t; strpad: H5T_str_t): herr_t;
begin
  Result := FH5Tset_strpad(type_id, strpad);
end;

function THDF5Dll.H5Tregister(pers: H5T_pers_t; name: PAnsiChar; src_id: hid_t; dst_id: hid_t; func: H5T_conv_t): herr_t;
begin
  Result := FH5Tregister(pers, name, src_id, dst_id, func);
end;

function THDF5Dll.H5Tunregister(pers: H5T_pers_t; name: PAnsiChar; src_id: hid_t; dst_id: hid_t; func: H5T_conv_t): herr_t;
begin
  Result := FH5Tunregister(pers, name, src_id, dst_id, func);
end;

function THDF5Dll.H5Tfind(src_id: hid_t; dst_id: hid_t; pcdata: PPH5T_cdata_t): H5T_conv_t;
begin
  Result := FH5Tfind(src_id, dst_id, pcdata);
end;

function THDF5Dll.H5Tcompiler_conv(src_id: hid_t; dst_id: hid_t): htri_t;
begin
  Result := FH5Tcompiler_conv(src_id, dst_id);
end;

function THDF5Dll.H5Tconvert(src_id: hid_t; dst_id: hid_t; nelmts: size_t; buf: Pointer; background: Pointer; plist_id: hid_t): herr_t;
begin
  Result := FH5Tconvert(src_id, dst_id, nelmts, buf, background, plist_id);
end;

function THDF5Dll.H5Dcreate2(loc_id: hid_t; name: PAnsiChar; type_id: hid_t; space_id: hid_t; lcpl_id: hid_t; dcpl_id: hid_t; dapl_id: hid_t): hid_t;
begin
  Result := FH5Dcreate2(loc_id, name, type_id, space_id, lcpl_id, dcpl_id, dapl_id);
end;

function THDF5Dll.H5Dcreate_anon(file_id: hid_t; type_id: hid_t; space_id: hid_t; plist_id: hid_t; dapl_id: hid_t): hid_t;
begin
  Result := FH5Dcreate_anon(file_id, type_id, space_id, plist_id, dapl_id);
end;

function THDF5Dll.H5Dopen2(file_id: hid_t; name: PAnsiChar; dapl_id: hid_t): hid_t;
begin
  Result := FH5Dopen2(file_id, name, dapl_id);
end;

function THDF5Dll.H5Dclose(dset_id: hid_t): herr_t;
begin
  Result := FH5Dclose(dset_id);
end;

function THDF5Dll.H5Dget_space(dset_id: hid_t): hid_t;
begin
  Result := FH5Dget_space(dset_id);
end;

function THDF5Dll.H5Dget_space_status(dset_id: hid_t; allocation: PH5D_space_status_t): herr_t;
begin
  Result := FH5Dget_space_status(dset_id, allocation);
end;

function THDF5Dll.H5Dget_type(dset_id: hid_t): hid_t;
begin
  Result := FH5Dget_type(dset_id);
end;

function THDF5Dll.H5Dget_create_plist(dset_id: hid_t): hid_t;
begin
  Result := FH5Dget_create_plist(dset_id);
end;

function THDF5Dll.H5Dget_access_plist(dset_id: hid_t): hid_t;
begin
  Result := FH5Dget_access_plist(dset_id);
end;

function THDF5Dll.H5Dget_storage_size(dset_id: hid_t): hsize_t;
begin
  Result := FH5Dget_storage_size(dset_id);
end;

function THDF5Dll.H5Dget_offset(dset_id: hid_t): haddr_t;
begin
  Result := FH5Dget_offset(dset_id);
end;

function THDF5Dll.H5Dread(dset_id: hid_t; mem_type_id: hid_t; mem_space_id: hid_t; file_space_id: hid_t; plist_id: hid_t; buf: Pointer): herr_t;
begin
  Result := FH5Dread(dset_id, mem_type_id, mem_space_id, file_space_id, plist_id, buf);
end;

function THDF5Dll.H5Dwrite(dset_id: hid_t; mem_type_id: hid_t; mem_space_id: hid_t; file_space_id: hid_t; plist_id: hid_t; buf: Pointer): herr_t;
begin
  Result := FH5Dwrite(dset_id, mem_type_id, mem_space_id, file_space_id, plist_id, buf);
end;

function THDF5Dll.H5Diterate(buf: Pointer; type_id: hid_t; space_id: hid_t; op: H5D_operator_t; operator_data: Pointer): herr_t;
begin
  Result := FH5Diterate(buf, type_id, space_id, op, operator_data);
end;

function THDF5Dll.H5Dvlen_reclaim(type_id: hid_t; space_id: hid_t; plist_id: hid_t; buf: Pointer): herr_t;
begin
  Result := FH5Dvlen_reclaim(type_id, space_id, plist_id, buf);
end;

function THDF5Dll.H5Dvlen_get_buf_size(dataset_id: hid_t; type_id: hid_t; space_id: hid_t; size: Phsize_t): herr_t;
begin
  Result := FH5Dvlen_get_buf_size(dataset_id, type_id, space_id, size);
end;

function THDF5Dll.H5Dfill(fill: Pointer; fill_type: hid_t; buf: Pointer; buf_type: hid_t; space: hid_t): herr_t;
begin
  Result := FH5Dfill(fill, fill_type, buf, buf_type, space);
end;

function THDF5Dll.H5Dset_extent(dset_id: hid_t; size: Phsize_t): herr_t;
begin
  Result := FH5Dset_extent(dset_id, size);
end;

function THDF5Dll.H5Dscatter(op: H5D_scatter_func_t; op_data: Pointer; type_id: hid_t; dst_space_id: hid_t; dst_buf: Pointer): herr_t;
begin
  Result := FH5Dscatter(op, op_data, type_id, dst_space_id, dst_buf);
end;

function THDF5Dll.H5Dgather(src_space_id: hid_t; src_buf: Pointer; type_id: hid_t; dst_buf_size: size_t; dst_buf: Pointer; op: H5D_gather_func_t; op_data: Pointer): herr_t;
begin
  Result := FH5Dgather(src_space_id, src_buf, type_id, dst_buf_size, dst_buf, op, op_data);
end;

function THDF5Dll.H5Ddebug(dset_id: hid_t): herr_t;
begin
  Result := FH5Ddebug(dset_id);
end;

function THDF5Dll.H5Eregister_class(cls_name: PAnsiChar; lib_name: PAnsiChar; version: PAnsiChar): hid_t;
begin
  Result := FH5Eregister_class(cls_name, lib_name, version);
end;

function THDF5Dll.H5Eunregister_class(class_id: hid_t): herr_t;
begin
  Result := FH5Eunregister_class(class_id);
end;

function THDF5Dll.H5Eclose_msg(err_id: hid_t): herr_t;
begin
  Result := FH5Eclose_msg(err_id);
end;

function THDF5Dll.H5Ecreate_msg(cls: hid_t; msg_type: H5E_type_t; msg: PAnsiChar): hid_t;
begin
  Result := FH5Ecreate_msg(cls, msg_type, msg);
end;

function THDF5Dll.H5Ecreate_stack: hid_t;
begin
  Result := FH5Ecreate_stack();
end;

function THDF5Dll.H5Eget_current_stack: hid_t;
begin
  Result := FH5Eget_current_stack();
end;

function THDF5Dll.H5Eclose_stack(stack_id: hid_t): herr_t;
begin
  Result := FH5Eclose_stack(stack_id);
end;

function THDF5Dll.H5Eget_class_name(class_id: hid_t; name: PAnsiChar; size: size_t): ssize_t;
begin
  Result := FH5Eget_class_name(class_id, name, size);
end;

function THDF5Dll.H5Eset_current_stack(err_stack_id: hid_t): herr_t;
begin
  Result := FH5Eset_current_stack(err_stack_id);
end;

function THDF5Dll.H5Epop(err_stack: hid_t; count: size_t): herr_t;
begin
  Result := FH5Epop(err_stack, count);
end;

function THDF5Dll.H5Eprint2(err_stack: hid_t; stream: PFILE): herr_t;
begin
  Result := FH5Eprint2(err_stack, stream);
end;

function THDF5Dll.H5Ewalk2(err_stack: hid_t; direction: H5E_direction_t; func: H5E_walk2_t; client_data: Pointer): herr_t;
begin
  Result := FH5Ewalk2(err_stack, direction, func, client_data);
end;

function THDF5Dll.H5Eget_auto2(estack_id: hid_t; func: PH5E_auto2_t; client_data: PPointer): herr_t;
begin
  Result := FH5Eget_auto2(estack_id, func, client_data);
end;

function THDF5Dll.H5Eset_auto2(estack_id: hid_t; func: H5E_auto2_t; client_data: Pointer): herr_t;
begin
  Result := FH5Eset_auto2(estack_id, func, client_data);
end;

function THDF5Dll.H5Eclear2(err_stack: hid_t): herr_t;
begin
  Result := FH5Eclear2(err_stack);
end;

function THDF5Dll.H5Eauto_is_v2(err_stack: hid_t; is_stack: PCardinal): herr_t;
begin
  Result := FH5Eauto_is_v2(err_stack, is_stack);
end;

function THDF5Dll.H5Eget_msg(msg_id: hid_t; typ: PH5E_type_t; msg: PAnsiChar; size: size_t): ssize_t;
begin
  Result := FH5Eget_msg(msg_id, typ, msg, size);
end;

function THDF5Dll.H5Eget_num(error_stack_id: hid_t): ssize_t;
begin
  Result := FH5Eget_num(error_stack_id);
end;

function THDF5Dll.H5Screate(typ: H5S_class_t): hid_t;
begin
  Result := FH5Screate(typ);
end;

function THDF5Dll.H5Screate_simple(rank: Integer; dims: Phsize_t; maxdims: Phsize_t): hid_t;
begin
  Result := FH5Screate_simple(rank, dims, maxdims);
end;

function THDF5Dll.H5Sset_extent_simple(space_id: hid_t; rank: Integer; dims: Phsize_t; max: Phsize_t): herr_t;
begin
  Result := FH5Sset_extent_simple(space_id, rank, dims, max);
end;

function THDF5Dll.H5Scopy(space_id: hid_t): hid_t;
begin
  Result := FH5Scopy(space_id);
end;

function THDF5Dll.H5Sclose(space_id: hid_t): herr_t;
begin
  Result := FH5Sclose(space_id);
end;

function THDF5Dll.H5Sencode(obj_id: hid_t; buf: Pointer; nalloc: Psize_t): herr_t;
begin
  Result := FH5Sencode(obj_id, buf, nalloc);
end;

function THDF5Dll.H5Sdecode(buf: Pointer): hid_t;
begin
  Result := FH5Sdecode(buf);
end;

function THDF5Dll.H5Sget_simple_extent_npoints(space_id: hid_t): hssize_t;
begin
  Result := FH5Sget_simple_extent_npoints(space_id);
end;

function THDF5Dll.H5Sget_simple_extent_ndims(space_id: hid_t): Integer;
begin
  Result := FH5Sget_simple_extent_ndims(space_id);
end;

function THDF5Dll.H5Sget_simple_extent_dims(space_id: hid_t; dims: Phsize_t; maxdims: Phsize_t): Integer;
begin
  Result := FH5Sget_simple_extent_dims(space_id, dims, maxdims);
end;

function THDF5Dll.H5Sis_simple(space_id: hid_t): htri_t;
begin
  Result := FH5Sis_simple(space_id);
end;

function THDF5Dll.H5Sget_select_npoints(spaceid: hid_t): hssize_t;
begin
  Result := FH5Sget_select_npoints(spaceid);
end;

function THDF5Dll.H5Sselect_hyperslab(space_id: hid_t; op: H5S_seloper_t; start: Phsize_t; _stride: Phsize_t; count: Phsize_t; _block: Phsize_t): herr_t;
begin
  Result := FH5Sselect_hyperslab(space_id, op, start, _stride, count, _block);
end;

function THDF5Dll.H5Sselect_elements(space_id: hid_t; op: H5S_seloper_t; num_elem: size_t; coord: Phsize_t): herr_t;
begin
  Result := FH5Sselect_elements(space_id, op, num_elem, coord);
end;

function THDF5Dll.H5Sget_simple_extent_type(space_id: hid_t): H5S_class_t;
begin
  Result := FH5Sget_simple_extent_type(space_id);
end;

function THDF5Dll.H5Sset_extent_none(space_id: hid_t): herr_t;
begin
  Result := FH5Sset_extent_none(space_id);
end;

function THDF5Dll.H5Sextent_copy(dst_id: hid_t; src_id: hid_t): herr_t;
begin
  Result := FH5Sextent_copy(dst_id, src_id);
end;

function THDF5Dll.H5Sextent_equal(sid1: hid_t; sid2: hid_t): htri_t;
begin
  Result := FH5Sextent_equal(sid1, sid2);
end;

function THDF5Dll.H5Sselect_all(spaceid: hid_t): herr_t;
begin
  Result := FH5Sselect_all(spaceid);
end;

function THDF5Dll.H5Sselect_none(spaceid: hid_t): herr_t;
begin
  Result := FH5Sselect_none(spaceid);
end;

function THDF5Dll.H5Soffset_simple(space_id: hid_t; offset: Phssize_t): herr_t;
begin
  Result := FH5Soffset_simple(space_id, offset);
end;

function THDF5Dll.H5Sselect_valid(spaceid: hid_t): htri_t;
begin
  Result := FH5Sselect_valid(spaceid);
end;

function THDF5Dll.H5Sget_select_hyper_nblocks(spaceid: hid_t): hssize_t;
begin
  Result := FH5Sget_select_hyper_nblocks(spaceid);
end;

function THDF5Dll.H5Sget_select_elem_npoints(spaceid: hid_t): hssize_t;
begin
  Result := FH5Sget_select_elem_npoints(spaceid);
end;

function THDF5Dll.H5Sget_select_hyper_blocklist(spaceid: hid_t; startblock: hsize_t; numblocks: hsize_t; buf: Phsize_t): herr_t;
begin
  Result := FH5Sget_select_hyper_blocklist(spaceid, startblock, numblocks, buf);
end;

function THDF5Dll.H5Sget_select_elem_pointlist(spaceid: hid_t; startpoint: hsize_t; numpoints: hsize_t; buf: Phsize_t): herr_t;
begin
  Result := FH5Sget_select_elem_pointlist(spaceid, startpoint, numpoints, buf);
end;

function THDF5Dll.H5Sget_select_bounds(spaceid: hid_t; start: Phsize_t; end_: Phsize_t): herr_t;
begin
  Result := FH5Sget_select_bounds(spaceid, start, end_);
end;

function THDF5Dll.H5Sget_select_type(spaceid: hid_t): H5S_sel_type;
begin
  Result := FH5Sget_select_type(spaceid);
end;

function THDF5Dll.H5Lmove(src_loc: hid_t; src_name: PAnsiChar; dst_loc: hid_t; dst_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lmove(src_loc, src_name, dst_loc, dst_name, lcpl_id, lapl_id);
end;

function THDF5Dll.H5Lcopy(src_loc: hid_t; src_name: PAnsiChar; dst_loc: hid_t; dst_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lcopy(src_loc, src_name, dst_loc, dst_name, lcpl_id, lapl_id);
end;

function THDF5Dll.H5Lcreate_hard(cur_loc: hid_t; cur_name: PAnsiChar; dst_loc: hid_t; dst_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lcreate_hard(cur_loc, cur_name, dst_loc, dst_name, lcpl_id, lapl_id);
end;

function THDF5Dll.H5Lcreate_soft(link_target: PAnsiChar; link_loc_id: hid_t; link_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lcreate_soft(link_target, link_loc_id, link_name, lcpl_id, lapl_id);
end;

function THDF5Dll.H5Ldelete(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): herr_t;
begin
  Result := FH5Ldelete(loc_id, name, lapl_id);
end;

function THDF5Dll.H5Ldelete_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Ldelete_by_idx(loc_id, group_name, idx_type, order, n, lapl_id);
end;

function THDF5Dll.H5Lget_val(loc_id: hid_t; name: PAnsiChar; buf: Pointer; size: size_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lget_val(loc_id, name, buf, size, lapl_id);
end;

function THDF5Dll.H5Lget_val_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; buf: Pointer; size: size_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lget_val_by_idx(loc_id, group_name, idx_type, order, n, buf, size, lapl_id);
end;

function THDF5Dll.H5Lexists(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): htri_t;
begin
  Result := FH5Lexists(loc_id, name, lapl_id);
end;

function THDF5Dll.H5Lget_info(loc_id: hid_t; name: PAnsiChar; linfo: PH5L_info_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lget_info(loc_id, name, linfo, lapl_id);
end;

function THDF5Dll.H5Lget_info_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; linfo: PH5L_info_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lget_info_by_idx(loc_id, group_name, idx_type, order, n, linfo, lapl_id);
end;

function THDF5Dll.H5Lget_name_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; name: PAnsiChar; size: size_t; lapl_id: hid_t): ssize_t;
begin
  Result := FH5Lget_name_by_idx(loc_id, group_name, idx_type, order, n, name, size, lapl_id);
end;

function THDF5Dll.H5Literate(grp_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5L_iterate_t; op_data: Pointer): herr_t;
begin
  Result := FH5Literate(grp_id, idx_type, order, idx, op, op_data);
end;

function THDF5Dll.H5Literate_by_name(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5L_iterate_t; op_data: Pointer; lapl_id: hid_t): herr_t;
begin
  Result := FH5Literate_by_name(loc_id, group_name, idx_type, order, idx, op, op_data, lapl_id);
end;

function THDF5Dll.H5Lvisit(grp_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; op: H5L_iterate_t; op_data: Pointer): herr_t;
begin
  Result := FH5Lvisit(grp_id, idx_type, order, op, op_data);
end;

function THDF5Dll.H5Lvisit_by_name(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; op: H5L_iterate_t; op_data: Pointer; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lvisit_by_name(loc_id, group_name, idx_type, order, op, op_data, lapl_id);
end;

function THDF5Dll.H5Lcreate_ud(link_loc_id: hid_t; link_name: PAnsiChar; link_type: H5L_type_t; udata: Pointer; udata_size: size_t; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lcreate_ud(link_loc_id, link_name, link_type, udata, udata_size, lcpl_id, lapl_id);
end;

function THDF5Dll.H5Lregister(cls: PH5L_class_t): herr_t;
begin
  Result := FH5Lregister(cls);
end;

function THDF5Dll.H5Lunregister(id: H5L_type_t): herr_t;
begin
  Result := FH5Lunregister(id);
end;

function THDF5Dll.H5Lis_registered(id: H5L_type_t): htri_t;
begin
  Result := FH5Lis_registered(id);
end;

function THDF5Dll.H5Lunpack_elink_val(ext_linkval: Pointer; link_size: size_t; flags: PCardinal; filename: PPAnsiChar; obj_path: PPAnsiChar): herr_t;
begin
  Result := FH5Lunpack_elink_val(ext_linkval, link_size, flags, filename, obj_path);
end;

function THDF5Dll.H5Lcreate_external(file_name: PAnsiChar; obj_name: PAnsiChar; link_loc_id: hid_t; link_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Lcreate_external(file_name, obj_name, link_loc_id, link_name, lcpl_id, lapl_id);
end;

function THDF5Dll.H5Oopen(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): hid_t;
begin
  Result := FH5Oopen(loc_id, name, lapl_id);
end;

function THDF5Dll.H5Oopen_by_addr(loc_id: hid_t; addr: haddr_t): hid_t;
begin
  Result := FH5Oopen_by_addr(loc_id, addr);
end;

function THDF5Dll.H5Oopen_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; lapl_id: hid_t): hid_t;
begin
  Result := FH5Oopen_by_idx(loc_id, group_name, idx_type, order, n, lapl_id);
end;

function THDF5Dll.H5Oexists_by_name(loc_id: hid_t; name: PAnsiChar; lapl_id: hid_t): htri_t;
begin
  Result := FH5Oexists_by_name(loc_id, name, lapl_id);
end;

function THDF5Dll.H5Oget_info(loc_id: hid_t; oinfo: PH5O_info_t): herr_t;
begin
  Result := FH5Oget_info(loc_id, oinfo);
end;

function THDF5Dll.H5Oget_info_by_name(loc_id: hid_t; name: PAnsiChar; oinfo: PH5O_info_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Oget_info_by_name(loc_id, name, oinfo, lapl_id);
end;

function THDF5Dll.H5Oget_info_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; oinfo: PH5O_info_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Oget_info_by_idx(loc_id, group_name, idx_type, order, n, oinfo, lapl_id);
end;

function THDF5Dll.H5Olink(obj_id: hid_t; new_loc_id: hid_t; new_name: PAnsiChar; lcpl_id: hid_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Olink(obj_id, new_loc_id, new_name, lcpl_id, lapl_id);
end;

function THDF5Dll.H5Oincr_refcount(object_id: hid_t): herr_t;
begin
  Result := FH5Oincr_refcount(object_id);
end;

function THDF5Dll.H5Odecr_refcount(object_id: hid_t): herr_t;
begin
  Result := FH5Odecr_refcount(object_id);
end;

function THDF5Dll.H5Ocopy(src_loc_id: hid_t; src_name: PAnsiChar; dst_loc_id: hid_t; dst_name: PAnsiChar; ocpypl_id: hid_t; lcpl_id: hid_t): herr_t;
begin
  Result := FH5Ocopy(src_loc_id, src_name, dst_loc_id, dst_name, ocpypl_id, lcpl_id);
end;

function THDF5Dll.H5Oset_comment(obj_id: hid_t; comment: PAnsiChar): herr_t;
begin
  Result := FH5Oset_comment(obj_id, comment);
end;

function THDF5Dll.H5Oset_comment_by_name(loc_id: hid_t; name: PAnsiChar; comment: PAnsiChar; lapl_id: hid_t): herr_t;
begin
  Result := FH5Oset_comment_by_name(loc_id, name, comment, lapl_id);
end;

function THDF5Dll.H5Oget_comment(obj_id: hid_t; comment: PAnsiChar; bufsize: size_t): ssize_t;
begin
  Result := FH5Oget_comment(obj_id, comment, bufsize);
end;

function THDF5Dll.H5Oget_comment_by_name(loc_id: hid_t; name: PAnsiChar; comment: PAnsiChar; bufsize: size_t; lapl_id: hid_t): ssize_t;
begin
  Result := FH5Oget_comment_by_name(loc_id, name, comment, bufsize, lapl_id);
end;

function THDF5Dll.H5Ovisit(obj_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; op: H5O_iterate_t; op_data: Pointer): herr_t;
begin
  Result := FH5Ovisit(obj_id, idx_type, order, op, op_data);
end;

function THDF5Dll.H5Ovisit_by_name(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; op: H5O_iterate_t; op_data: Pointer; lapl_id: hid_t): herr_t;
begin
  Result := FH5Ovisit_by_name(loc_id, obj_name, idx_type, order, op, op_data, lapl_id);
end;

function THDF5Dll.H5Oclose(object_id: hid_t): herr_t;
begin
  Result := FH5Oclose(object_id);
end;

function THDF5Dll.H5Fis_hdf5(filename: PAnsiChar): htri_t;
begin
  Result := FH5Fis_hdf5(filename);
end;

function THDF5Dll.H5Fcreate(filename: PAnsiChar; flags: Cardinal; create_plist: hid_t; access_plist: hid_t): hid_t;
begin
  Result := FH5Fcreate(filename, flags, create_plist, access_plist);
end;

function THDF5Dll.H5Fopen(filename: PAnsiChar; flags: Cardinal; access_plist: hid_t): hid_t;
begin
  Result := FH5Fopen(filename, flags, access_plist);
end;

function THDF5Dll.H5Freopen(file_id: hid_t): hid_t;
begin
  Result := FH5Freopen(file_id);
end;

function THDF5Dll.H5Fflush(object_id: hid_t; scope: H5F_scope_t): herr_t;
begin
  Result := FH5Fflush(object_id, scope);
end;

function THDF5Dll.H5Fclose(file_id: hid_t): herr_t;
begin
  Result := FH5Fclose(file_id);
end;

function THDF5Dll.H5Fget_create_plist(file_id: hid_t): hid_t;
begin
  Result := FH5Fget_create_plist(file_id);
end;

function THDF5Dll.H5Fget_access_plist(file_id: hid_t): hid_t;
begin
  Result := FH5Fget_access_plist(file_id);
end;

function THDF5Dll.H5Fget_intent(file_id: hid_t; intent: PCardinal): herr_t;
begin
  Result := FH5Fget_intent(file_id, intent);
end;

function THDF5Dll.H5Fget_obj_count(file_id: hid_t; types: Cardinal): ssize_t;
begin
  Result := FH5Fget_obj_count(file_id, types);
end;

function THDF5Dll.H5Fget_obj_ids(file_id: hid_t; types: Cardinal; max_objs: size_t; obj_id_list: Phid_t): ssize_t;
begin
  Result := FH5Fget_obj_ids(file_id, types, max_objs, obj_id_list);
end;

function THDF5Dll.H5Fget_vfd_handle(file_id: hid_t; fapl: hid_t; file_handle: PPointer): herr_t;
begin
  Result := FH5Fget_vfd_handle(file_id, fapl, file_handle);
end;

function THDF5Dll.H5Fmount(loc: hid_t; name: PAnsiChar; child: hid_t; plist: hid_t): herr_t;
begin
  Result := FH5Fmount(loc, name, child, plist);
end;

function THDF5Dll.H5Funmount(loc: hid_t; name: PAnsiChar): herr_t;
begin
  Result := FH5Funmount(loc, name);
end;

function THDF5Dll.H5Fget_freespace(file_id: hid_t): hssize_t;
begin
  Result := FH5Fget_freespace(file_id);
end;

function THDF5Dll.H5Fget_filesize(file_id: hid_t; size: Phsize_t): herr_t;
begin
  Result := FH5Fget_filesize(file_id, size);
end;

function THDF5Dll.H5Fget_file_image(file_id: hid_t; buf_ptr: Pointer; buf_len: size_t): ssize_t;
begin
  Result := FH5Fget_file_image(file_id, buf_ptr, buf_len);
end;

function THDF5Dll.H5Fget_mdc_config(file_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t;
begin
  Result := FH5Fget_mdc_config(file_id, config_ptr);
end;

function THDF5Dll.H5Fset_mdc_config(file_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t;
begin
  Result := FH5Fset_mdc_config(file_id, config_ptr);
end;

function THDF5Dll.H5Fget_mdc_hit_rate(file_id: hid_t; hit_rate_ptr: Pdouble): herr_t;
begin
  Result := FH5Fget_mdc_hit_rate(file_id, hit_rate_ptr);
end;

function THDF5Dll.H5Fget_mdc_size(file_id: hid_t; max_size_ptr: Psize_t; min_clean_size_ptr: Psize_t; cur_size_ptr: Psize_t; cur_num_entries_ptr: PInteger): herr_t;
begin
  Result := FH5Fget_mdc_size(file_id, max_size_ptr, min_clean_size_ptr, cur_size_ptr, cur_num_entries_ptr);
end;

function THDF5Dll.H5Freset_mdc_hit_rate_stats(file_id: hid_t): herr_t;
begin
  Result := FH5Freset_mdc_hit_rate_stats(file_id);
end;

function THDF5Dll.H5Fget_name(obj_id: hid_t; name: PAnsiChar; size: size_t): ssize_t;
begin
  Result := FH5Fget_name(obj_id, name, size);
end;

function THDF5Dll.H5Fget_info(obj_id: hid_t; bh_info: PH5F_info_t): herr_t;
begin
  Result := FH5Fget_info(obj_id, bh_info);
end;

function THDF5Dll.H5Fclear_elink_file_cache(file_id: hid_t): herr_t;
begin
  Result := FH5Fclear_elink_file_cache(file_id);
end;

function THDF5Dll.H5Acreate2(loc_id: hid_t; attr_name: PAnsiChar; type_id: hid_t; space_id: hid_t; acpl_id: hid_t; aapl_id: hid_t): hid_t;
begin
  Result := FH5Acreate2(loc_id, attr_name, type_id, space_id, acpl_id, aapl_id);
end;

function THDF5Dll.H5Acreate_by_name(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; type_id: hid_t; space_id: hid_t; acpl_id: hid_t; aapl_id: hid_t; lapl_id: hid_t): hid_t;
begin
  Result := FH5Acreate_by_name(loc_id, obj_name, attr_name, type_id, space_id, acpl_id, aapl_id, lapl_id);
end;

function THDF5Dll.H5Aopen(obj_id: hid_t; attr_name: PAnsiChar; aapl_id: hid_t): hid_t;
begin
  Result := FH5Aopen(obj_id, attr_name, aapl_id);
end;

function THDF5Dll.H5Aopen_by_name(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; aapl_id: hid_t; lapl_id: hid_t): hid_t;
begin
  Result := FH5Aopen_by_name(loc_id, obj_name, attr_name, aapl_id, lapl_id);
end;

function THDF5Dll.H5Aopen_by_idx(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; aapl_id: hid_t; lapl_id: hid_t): hid_t;
begin
  Result := FH5Aopen_by_idx(loc_id, obj_name, idx_type, order, n, aapl_id, lapl_id);
end;

function THDF5Dll.H5Awrite(attr_id: hid_t; type_id: hid_t; buf: Pointer): herr_t;
begin
  Result := FH5Awrite(attr_id, type_id, buf);
end;

function THDF5Dll.H5Aread(attr_id: hid_t; type_id: hid_t; buf: Pointer): herr_t;
begin
  Result := FH5Aread(attr_id, type_id, buf);
end;

function THDF5Dll.H5Aclose(attr_id: hid_t): herr_t;
begin
  Result := FH5Aclose(attr_id);
end;

function THDF5Dll.H5Aget_space(attr_id: hid_t): hid_t;
begin
  Result := FH5Aget_space(attr_id);
end;

function THDF5Dll.H5Aget_type(attr_id: hid_t): hid_t;
begin
  Result := FH5Aget_type(attr_id);
end;

function THDF5Dll.H5Aget_create_plist(attr_id: hid_t): hid_t;
begin
  Result := FH5Aget_create_plist(attr_id);
end;

function THDF5Dll.H5Aget_name(attr_id: hid_t; buf_size: size_t; buf: PAnsiChar): ssize_t;
begin
  Result := FH5Aget_name(attr_id, buf_size, buf);
end;

function THDF5Dll.H5Aget_name_by_idx(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; name: PAnsiChar; size: size_t; lapl_id: hid_t): ssize_t;
begin
  Result := FH5Aget_name_by_idx(loc_id, obj_name, idx_type, order, n, name, size, lapl_id);
end;

function THDF5Dll.H5Aget_storage_size(attr_id: hid_t): hsize_t;
begin
  Result := FH5Aget_storage_size(attr_id);
end;

function THDF5Dll.H5Aget_info(attr_id: hid_t; ainfo: PH5A_info_t): herr_t;
begin
  Result := FH5Aget_info(attr_id, ainfo);
end;

function THDF5Dll.H5Aget_info_by_name(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; ainfo: PH5A_info_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Aget_info_by_name(loc_id, obj_name, attr_name, ainfo, lapl_id);
end;

function THDF5Dll.H5Aget_info_by_idx(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; ainfo: PH5A_info_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Aget_info_by_idx(loc_id, obj_name, idx_type, order, n, ainfo, lapl_id);
end;

function THDF5Dll.H5Arename(loc_id: hid_t; old_name: PAnsiChar; new_name: PAnsiChar): herr_t;
begin
  Result := FH5Arename(loc_id, old_name, new_name);
end;

function THDF5Dll.H5Arename_by_name(loc_id: hid_t; obj_name: PAnsiChar; old_attr_name: PAnsiChar; new_attr_name: PAnsiChar; lapl_id: hid_t): herr_t;
begin
  Result := FH5Arename_by_name(loc_id, obj_name, old_attr_name, new_attr_name, lapl_id);
end;

function THDF5Dll.H5Aiterate2(loc_id: hid_t; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5A_operator2_t; op_data: Pointer): herr_t;
begin
  Result := FH5Aiterate2(loc_id, idx_type, order, idx, op, op_data);
end;

function THDF5Dll.H5Aiterate_by_name(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; idx: Phsize_t; op: H5A_operator2_t; op_data: Pointer; lapd_id: hid_t): herr_t;
begin
  Result := FH5Aiterate_by_name(loc_id, obj_name, idx_type, order, idx, op, op_data, lapd_id);
end;

function THDF5Dll.H5Adelete(loc_id: hid_t; name: PAnsiChar): herr_t;
begin
  Result := FH5Adelete(loc_id, name);
end;

function THDF5Dll.H5Adelete_by_name(loc_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; lapl_id: hid_t): herr_t;
begin
  Result := FH5Adelete_by_name(loc_id, obj_name, attr_name, lapl_id);
end;

function THDF5Dll.H5Adelete_by_idx(loc_id: hid_t; obj_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Adelete_by_idx(loc_id, obj_name, idx_type, order, n, lapl_id);
end;

function THDF5Dll.H5Aexists(obj_id: hid_t; attr_name: PAnsiChar): htri_t;
begin
  Result := FH5Aexists(obj_id, attr_name);
end;

function THDF5Dll.H5Aexists_by_name(obj_id: hid_t; obj_name: PAnsiChar; attr_name: PAnsiChar; lapl_id: hid_t): htri_t;
begin
  Result := FH5Aexists_by_name(obj_id, obj_name, attr_name, lapl_id);
end;

function THDF5Dll.H5FDregister(cls: PH5FD_class_t): hid_t;
begin
  Result := FH5FDregister(cls);
end;

function THDF5Dll.H5FDunregister(driver_id: hid_t): herr_t;
begin
  Result := FH5FDunregister(driver_id);
end;

function THDF5Dll.H5FDopen(name: PAnsiChar; flags: Cardinal; fapl_id: hid_t; maxaddr: haddr_t): PH5FD_t;
begin
  Result := FH5FDopen(name, flags, fapl_id, maxaddr);
end;

function THDF5Dll.H5FDclose(file_: PH5FD_t): herr_t;
begin
  Result := FH5FDclose(file_);
end;

function THDF5Dll.H5FDcmp(f1: PH5FD_t; f2: PH5FD_t): Integer;
begin
  Result := FH5FDcmp(f1, f2);
end;

function THDF5Dll.H5FDquery(f: PH5FD_t; flags: PCardinal): Integer;
begin
  Result := FH5FDquery(f, flags);
end;

function THDF5Dll.H5FDalloc(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; size: hsize_t): haddr_t;
begin
  Result := FH5FDalloc(file_, typ, dxpl_id, size);
end;

function THDF5Dll.H5FDfree(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; addr: haddr_t; size: hsize_t): herr_t;
begin
  Result := FH5FDfree(file_, typ, dxpl_id, addr, size);
end;

function THDF5Dll.H5FDget_eoa(file_: PH5FD_t; typ: H5FD_mem_t): haddr_t;
begin
  Result := FH5FDget_eoa(file_, typ);
end;

function THDF5Dll.H5FDset_eoa(file_: PH5FD_t; typ: H5FD_mem_t; eoa: haddr_t): herr_t;
begin
  Result := FH5FDset_eoa(file_, typ, eoa);
end;

function THDF5Dll.H5FDget_eof(file_: PH5FD_t): haddr_t;
begin
  Result := FH5FDget_eof(file_);
end;

function THDF5Dll.H5FDget_vfd_handle(file_: PH5FD_t; fapl: hid_t; file_handle: PPointer): herr_t;
begin
  Result := FH5FDget_vfd_handle(file_, fapl, file_handle);
end;

function THDF5Dll.H5FDread(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; addr: haddr_t; size: size_t; buf: Pointer): herr_t;
begin
  Result := FH5FDread(file_, typ, dxpl_id, addr, size, buf);
end;

function THDF5Dll.H5FDwrite(file_: PH5FD_t; typ: H5FD_mem_t; dxpl_id: hid_t; addr: haddr_t; size: size_t; buf: Pointer): herr_t;
begin
  Result := FH5FDwrite(file_, typ, dxpl_id, addr, size, buf);
end;

function THDF5Dll.H5FDflush(file_: PH5FD_t; dxpl_id: hid_t; closing: Cardinal): herr_t;
begin
  Result := FH5FDflush(file_, dxpl_id, closing);
end;

function THDF5Dll.H5FDtruncate(file_: PH5FD_t; dxpl_id: hid_t; closing: hbool_t): herr_t;
begin
  Result := FH5FDtruncate(file_, dxpl_id, closing);
end;

function THDF5Dll.H5Gcreate2(loc_id: hid_t; name: PAnsiChar; lcpl_id: hid_t; gcpl_id: hid_t; gapl_id: hid_t): hid_t;
begin
  Result := FH5Gcreate2(loc_id, name, lcpl_id, gcpl_id, gapl_id);
end;

function THDF5Dll.H5Gcreate_anon(loc_id: hid_t; gcpl_id: hid_t; gapl_id: hid_t): hid_t;
begin
  Result := FH5Gcreate_anon(loc_id, gcpl_id, gapl_id);
end;

function THDF5Dll.H5Gopen2(loc_id: hid_t; name: PAnsiChar; gapl_id: hid_t): hid_t;
begin
  Result := FH5Gopen2(loc_id, name, gapl_id);
end;

function THDF5Dll.H5Gget_create_plist(group_id: hid_t): hid_t;
begin
  Result := FH5Gget_create_plist(group_id);
end;

function THDF5Dll.H5Gget_info(loc_id: hid_t; ginfo: PH5G_info_t): herr_t;
begin
  Result := FH5Gget_info(loc_id, ginfo);
end;

function THDF5Dll.H5Gget_info_by_name(loc_id: hid_t; name: PAnsiChar; ginfo: PH5G_info_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Gget_info_by_name(loc_id, name, ginfo, lapl_id);
end;

function THDF5Dll.H5Gget_info_by_idx(loc_id: hid_t; group_name: PAnsiChar; idx_type: H5_index_t; order: H5_iter_order_t; n: hsize_t; ginfo: PH5G_info_t; lapl_id: hid_t): herr_t;
begin
  Result := FH5Gget_info_by_idx(loc_id, group_name, idx_type, order, n, ginfo, lapl_id);
end;

function THDF5Dll.H5Gclose(group_id: hid_t): herr_t;
begin
  Result := FH5Gclose(group_id);
end;

function THDF5Dll.H5Rcreate(ref: Pointer; loc_id: hid_t; name: PAnsiChar; ref_type: H5R_type_t; space_id: hid_t): herr_t;
begin
  Result := FH5Rcreate(ref, loc_id, name, ref_type, space_id);
end;

function THDF5Dll.H5Rdereference(dataset: hid_t; ref_type: H5R_type_t; ref: Pointer): hid_t;
begin
  Result := FH5Rdereference(dataset, ref_type, ref);
end;

function THDF5Dll.H5Rget_region(dataset: hid_t; ref_type: H5R_type_t; ref: Pointer): hid_t;
begin
  Result := FH5Rget_region(dataset, ref_type, ref);
end;

function THDF5Dll.H5Rget_obj_type2(id: hid_t; ref_type: H5R_type_t; _ref: Pointer; obj_type: PH5O_type_t): herr_t;
begin
  Result := FH5Rget_obj_type2(id, ref_type, _ref, obj_type);
end;

function THDF5Dll.H5Rget_name(loc_id: hid_t; ref_type: H5R_type_t; ref: Pointer; name: PAnsiChar; size: size_t): ssize_t;
begin
  Result := FH5Rget_name(loc_id, ref_type, ref, name, size);
end;

function THDF5Dll.H5Pcreate_class(parent: hid_t; name: PAnsiChar; cls_create: H5P_cls_create_func_t; create_data: Pointer; cls_copy: H5P_cls_copy_func_t; copy_data: Pointer; cls_close: H5P_cls_close_func_t; close_data: Pointer): hid_t;
begin
  Result := FH5Pcreate_class(parent, name, cls_create, create_data, cls_copy, copy_data, cls_close, close_data);
end;

function THDF5Dll.H5Pget_class_name(pclass_id: hid_t): PAnsiChar;
begin
  Result := FH5Pget_class_name(pclass_id);
end;

function THDF5Dll.H5Pcreate(cls_id: hid_t): hid_t;
begin
  Result := FH5Pcreate(cls_id);
end;

function THDF5Dll.H5Pregister2(cls_id: hid_t; name: PAnsiChar; size: size_t; def_value: Pointer; prp_create: H5P_prp_create_func_t; prp_set: H5P_prp_set_func_t; prp_get: H5P_prp_get_func_t; prp_del: H5P_prp_delete_func_t; prp_copy: H5P_prp_copy_func_t; prp_cmp: H5P_prp_compare_func_t; prp_close: H5P_prp_close_func_t): herr_t;
begin
  Result := FH5Pregister2(cls_id, name, size, def_value, prp_create, prp_set, prp_get, prp_del, prp_copy, prp_cmp, prp_close);
end;

function THDF5Dll.H5Pinsert2(plist_id: hid_t; name: PAnsiChar; size: size_t; value: Pointer; prp_set: H5P_prp_set_func_t; prp_get: H5P_prp_get_func_t; prp_delete: H5P_prp_delete_func_t; prp_copy: H5P_prp_copy_func_t; prp_cmp: H5P_prp_compare_func_t; prp_close: H5P_prp_close_func_t): herr_t;
begin
  Result := FH5Pinsert2(plist_id, name, size, value, prp_set, prp_get, prp_delete, prp_copy, prp_cmp, prp_close);
end;

function THDF5Dll.H5Pset(plist_id: hid_t; name: PAnsiChar; value: Pointer): herr_t;
begin
  Result := FH5Pset(plist_id, name, value);
end;

function THDF5Dll.H5Pexist(plist_id: hid_t; name: PAnsiChar): htri_t;
begin
  Result := FH5Pexist(plist_id, name);
end;

function THDF5Dll.H5Pget_size(id: hid_t; name: PAnsiChar; size: Psize_t): herr_t;
begin
  Result := FH5Pget_size(id, name, size);
end;

function THDF5Dll.H5Pget_nprops(id: hid_t; nprops: Psize_t): herr_t;
begin
  Result := FH5Pget_nprops(id, nprops);
end;

function THDF5Dll.H5Pget_class(plist_id: hid_t): hid_t;
begin
  Result := FH5Pget_class(plist_id);
end;

function THDF5Dll.H5Pget_class_parent(pclass_id: hid_t): hid_t;
begin
  Result := FH5Pget_class_parent(pclass_id);
end;

function THDF5Dll.H5Pget(plist_id: hid_t; name: PAnsiChar; value: Pointer): herr_t;
begin
  Result := FH5Pget(plist_id, name, value);
end;

function THDF5Dll.H5Pequal(id1: hid_t; id2: hid_t): htri_t;
begin
  Result := FH5Pequal(id1, id2);
end;

function THDF5Dll.H5Pisa_class(plist_id: hid_t; pclass_id: hid_t): htri_t;
begin
  Result := FH5Pisa_class(plist_id, pclass_id);
end;

function THDF5Dll.H5Piterate(id: hid_t; idx: PInteger; iter_func: H5P_iterate_t; iter_data: Pointer): Integer;
begin
  Result := FH5Piterate(id, idx, iter_func, iter_data);
end;

function THDF5Dll.H5Pcopy_prop(dst_id: hid_t; src_id: hid_t; name: PAnsiChar): herr_t;
begin
  Result := FH5Pcopy_prop(dst_id, src_id, name);
end;

function THDF5Dll.H5Premove(plist_id: hid_t; name: PAnsiChar): herr_t;
begin
  Result := FH5Premove(plist_id, name);
end;

function THDF5Dll.H5Punregister(pclass_id: hid_t; name: PAnsiChar): herr_t;
begin
  Result := FH5Punregister(pclass_id, name);
end;

function THDF5Dll.H5Pclose_class(plist_id: hid_t): herr_t;
begin
  Result := FH5Pclose_class(plist_id);
end;

function THDF5Dll.H5Pclose(plist_id: hid_t): herr_t;
begin
  Result := FH5Pclose(plist_id);
end;

function THDF5Dll.H5Pcopy(plist_id: hid_t): hid_t;
begin
  Result := FH5Pcopy(plist_id);
end;

function THDF5Dll.H5Pset_attr_phase_change(plist_id: hid_t; max_compact: Cardinal; min_dense: Cardinal): herr_t;
begin
  Result := FH5Pset_attr_phase_change(plist_id, max_compact, min_dense);
end;

function THDF5Dll.H5Pget_attr_phase_change(plist_id: hid_t; max_compact: PCardinal; min_dense: PCardinal): herr_t;
begin
  Result := FH5Pget_attr_phase_change(plist_id, max_compact, min_dense);
end;

function THDF5Dll.H5Pset_attr_creation_order(plist_id: hid_t; crt_order_flags: Cardinal): herr_t;
begin
  Result := FH5Pset_attr_creation_order(plist_id, crt_order_flags);
end;

function THDF5Dll.H5Pget_attr_creation_order(plist_id: hid_t; crt_order_flags: PCardinal): herr_t;
begin
  Result := FH5Pget_attr_creation_order(plist_id, crt_order_flags);
end;

function THDF5Dll.H5Pset_obj_track_times(plist_id: hid_t; track_times: hbool_t): herr_t;
begin
  Result := FH5Pset_obj_track_times(plist_id, track_times);
end;

function THDF5Dll.H5Pget_obj_track_times(plist_id: hid_t; track_times: Phbool_t): herr_t;
begin
  Result := FH5Pget_obj_track_times(plist_id, track_times);
end;

function THDF5Dll.H5Pmodify_filter(plist_id: hid_t; filter: H5Z_filter_t; flags: Cardinal; cd_nelmts: size_t; cd_values: PCardinal): herr_t;
begin
  Result := FH5Pmodify_filter(plist_id, filter, flags, cd_nelmts, cd_values);
end;

function THDF5Dll.H5Pset_filter(plist_id: hid_t; filter: H5Z_filter_t; flags: Cardinal; cd_nelmts: size_t; c_values: PCardinal): herr_t;
begin
  Result := FH5Pset_filter(plist_id, filter, flags, cd_nelmts, c_values);
end;

function THDF5Dll.H5Pget_nfilters(plist_id: hid_t): Integer;
begin
  Result := FH5Pget_nfilters(plist_id);
end;

function THDF5Dll.H5Pget_filter2(plist_id: hid_t; filter: Cardinal; flags: PCardinal; cd_nelmts: Psize_t; cd_values: PCardinal; namelen: size_t; name: PAnsiChar; filter_config: PCardinal): H5Z_filter_t;
begin
  Result := FH5Pget_filter2(plist_id, filter, flags, cd_nelmts, cd_values, namelen, name, filter_config);
end;

function THDF5Dll.H5Pget_filter_by_id2(plist_id: hid_t; id: H5Z_filter_t; flags: PCardinal; cd_nelmts: Psize_t; cd_values: PCardinal; namelen: size_t; name: PAnsiChar; filter_config: PCardinal): herr_t;
begin
  Result := FH5Pget_filter_by_id2(plist_id, id, flags, cd_nelmts, cd_values, namelen, name, filter_config);
end;

function THDF5Dll.H5Pall_filters_avail(plist_id: hid_t): htri_t;
begin
  Result := FH5Pall_filters_avail(plist_id);
end;

function THDF5Dll.H5Premove_filter(plist_id: hid_t; filter: H5Z_filter_t): herr_t;
begin
  Result := FH5Premove_filter(plist_id, filter);
end;

function THDF5Dll.H5Pset_deflate(plist_id: hid_t; aggression: Cardinal): herr_t;
begin
  Result := FH5Pset_deflate(plist_id, aggression);
end;

function THDF5Dll.H5Pset_fletcher32(plist_id: hid_t): herr_t;
begin
  Result := FH5Pset_fletcher32(plist_id);
end;

function THDF5Dll.H5Pget_version(plist_id: hid_t; boot: PCardinal; freelist: PCardinal; stab: PCardinal; shhdr: PCardinal): herr_t;
begin
  Result := FH5Pget_version(plist_id, boot, freelist, stab, shhdr);
end;

function THDF5Dll.H5Pset_userblock(plist_id: hid_t; size: hsize_t): herr_t;
begin
  Result := FH5Pset_userblock(plist_id, size);
end;

function THDF5Dll.H5Pget_userblock(plist_id: hid_t; size: Phsize_t): herr_t;
begin
  Result := FH5Pget_userblock(plist_id, size);
end;

function THDF5Dll.H5Pset_sizes(plist_id: hid_t; sizeof_addr: size_t; sizeof_size: size_t): herr_t;
begin
  Result := FH5Pset_sizes(plist_id, sizeof_addr, sizeof_size);
end;

function THDF5Dll.H5Pget_sizes(plist_id: hid_t; sizeof_addr: Psize_t; sizeof_size: Psize_t): herr_t;
begin
  Result := FH5Pget_sizes(plist_id, sizeof_addr, sizeof_size);
end;

function THDF5Dll.H5Pset_sym_k(plist_id: hid_t; ik: Cardinal; lk: Cardinal): herr_t;
begin
  Result := FH5Pset_sym_k(plist_id, ik, lk);
end;

function THDF5Dll.H5Pget_sym_k(plist_id: hid_t; ik: PCardinal; lk: PCardinal): herr_t;
begin
  Result := FH5Pget_sym_k(plist_id, ik, lk);
end;

function THDF5Dll.H5Pset_istore_k(plist_id: hid_t; ik: Cardinal): herr_t;
begin
  Result := FH5Pset_istore_k(plist_id, ik);
end;

function THDF5Dll.H5Pget_istore_k(plist_id: hid_t; ik: PCardinal): herr_t;
begin
  Result := FH5Pget_istore_k(plist_id, ik);
end;

function THDF5Dll.H5Pset_shared_mesg_nindexes(plist_id: hid_t; nindexes: Cardinal): herr_t;
begin
  Result := FH5Pset_shared_mesg_nindexes(plist_id, nindexes);
end;

function THDF5Dll.H5Pget_shared_mesg_nindexes(plist_id: hid_t; nindexes: PCardinal): herr_t;
begin
  Result := FH5Pget_shared_mesg_nindexes(plist_id, nindexes);
end;

function THDF5Dll.H5Pset_shared_mesg_index(plist_id: hid_t; index_num: Cardinal; mesg_type_flags: Cardinal; min_mesg_size: Cardinal): herr_t;
begin
  Result := FH5Pset_shared_mesg_index(plist_id, index_num, mesg_type_flags, min_mesg_size);
end;

function THDF5Dll.H5Pget_shared_mesg_index(plist_id: hid_t; index_num: Cardinal; mesg_type_flags: PCardinal; min_mesg_size: PCardinal): herr_t;
begin
  Result := FH5Pget_shared_mesg_index(plist_id, index_num, mesg_type_flags, min_mesg_size);
end;

function THDF5Dll.H5Pset_shared_mesg_phase_change(plist_id: hid_t; max_list: Cardinal; min_btree: Cardinal): herr_t;
begin
  Result := FH5Pset_shared_mesg_phase_change(plist_id, max_list, min_btree);
end;

function THDF5Dll.H5Pget_shared_mesg_phase_change(plist_id: hid_t; max_list: PCardinal; min_btree: PCardinal): herr_t;
begin
  Result := FH5Pget_shared_mesg_phase_change(plist_id, max_list, min_btree);
end;

function THDF5Dll.H5Pset_alignment(fapl_id: hid_t; threshold: hsize_t; alignment: hsize_t): herr_t;
begin
  Result := FH5Pset_alignment(fapl_id, threshold, alignment);
end;

function THDF5Dll.H5Pget_alignment(fapl_id: hid_t; threshold: Phsize_t; alignment: Phsize_t): herr_t;
begin
  Result := FH5Pget_alignment(fapl_id, threshold, alignment);
end;

function THDF5Dll.H5Pset_driver(plist_id: hid_t; driver_id: hid_t; driver_info: Pointer): herr_t;
begin
  Result := FH5Pset_driver(plist_id, driver_id, driver_info);
end;

function THDF5Dll.H5Pget_driver(plist_id: hid_t): hid_t;
begin
  Result := FH5Pget_driver(plist_id);
end;

function THDF5Dll.H5Pget_driver_info(plist_id: hid_t): Pointer;
begin
  Result := FH5Pget_driver_info(plist_id);
end;

function THDF5Dll.H5Pset_family_offset(fapl_id: hid_t; offset: hsize_t): herr_t;
begin
  Result := FH5Pset_family_offset(fapl_id, offset);
end;

function THDF5Dll.H5Pget_family_offset(fapl_id: hid_t; offset: Phsize_t): herr_t;
begin
  Result := FH5Pget_family_offset(fapl_id, offset);
end;

function THDF5Dll.H5Pset_multi_type(fapl_id: hid_t; typ: H5FD_mem_t): herr_t;
begin
  Result := FH5Pset_multi_type(fapl_id, typ);
end;

function THDF5Dll.H5Pget_multi_type(fapl_id: hid_t; typ: PH5FD_mem_t): herr_t;
begin
  Result := FH5Pget_multi_type(fapl_id, typ);
end;

function THDF5Dll.H5Pset_cache(plist_id: hid_t; mdc_nelmts: Integer; rdcc_nslots: size_t; rdcc_nbytes: size_t; rdcc_w0: double): herr_t;
begin
  Result := FH5Pset_cache(plist_id, mdc_nelmts, rdcc_nslots, rdcc_nbytes, rdcc_w0);
end;

function THDF5Dll.H5Pget_cache(plist_id: hid_t; mdc_nelmts: PInteger; rdcc_nslots: Psize_t; rdcc_nbytes: Psize_t; rdcc_w0: Pdouble): herr_t;
begin
  Result := FH5Pget_cache(plist_id, mdc_nelmts, rdcc_nslots, rdcc_nbytes, rdcc_w0);
end;

function THDF5Dll.H5Pset_mdc_config(plist_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t;
begin
  Result := FH5Pset_mdc_config(plist_id, config_ptr);
end;

function THDF5Dll.H5Pget_mdc_config(plist_id: hid_t; config_ptr: PH5AC_cache_config_t): herr_t;
begin
  Result := FH5Pget_mdc_config(plist_id, config_ptr);
end;

function THDF5Dll.H5Pset_gc_references(fapl_id: hid_t; gc_ref: Cardinal): herr_t;
begin
  Result := FH5Pset_gc_references(fapl_id, gc_ref);
end;

function THDF5Dll.H5Pget_gc_references(fapl_id: hid_t; gc_ref: PCardinal): herr_t;
begin
  Result := FH5Pget_gc_references(fapl_id, gc_ref);
end;

function THDF5Dll.H5Pset_fclose_degree(fapl_id: hid_t; degree: H5F_close_degree_t): herr_t;
begin
  Result := FH5Pset_fclose_degree(fapl_id, degree);
end;

function THDF5Dll.H5Pget_fclose_degree(fapl_id: hid_t; degree: PH5F_close_degree_t): herr_t;
begin
  Result := FH5Pget_fclose_degree(fapl_id, degree);
end;

function THDF5Dll.H5Pset_meta_block_size(fapl_id: hid_t; size: hsize_t): herr_t;
begin
  Result := FH5Pset_meta_block_size(fapl_id, size);
end;

function THDF5Dll.H5Pget_meta_block_size(fapl_id: hid_t; size: Phsize_t): herr_t;
begin
  Result := FH5Pget_meta_block_size(fapl_id, size);
end;

function THDF5Dll.H5Pset_sieve_buf_size(fapl_id: hid_t; size: size_t): herr_t;
begin
  Result := FH5Pset_sieve_buf_size(fapl_id, size);
end;

function THDF5Dll.H5Pget_sieve_buf_size(fapl_id: hid_t; size: Psize_t): herr_t;
begin
  Result := FH5Pget_sieve_buf_size(fapl_id, size);
end;

function THDF5Dll.H5Pset_small_data_block_size(fapl_id: hid_t; size: hsize_t): herr_t;
begin
  Result := FH5Pset_small_data_block_size(fapl_id, size);
end;

function THDF5Dll.H5Pget_small_data_block_size(fapl_id: hid_t; size: Phsize_t): herr_t;
begin
  Result := FH5Pget_small_data_block_size(fapl_id, size);
end;

function THDF5Dll.H5Pset_libver_bounds(plist_id: hid_t; low: H5F_libver_t; high: H5F_libver_t): herr_t;
begin
  Result := FH5Pset_libver_bounds(plist_id, low, high);
end;

function THDF5Dll.H5Pget_libver_bounds(plist_id: hid_t; low: PH5F_libver_t; high: PH5F_libver_t): herr_t;
begin
  Result := FH5Pget_libver_bounds(plist_id, low, high);
end;

function THDF5Dll.H5Pset_elink_file_cache_size(plist_id: hid_t; efc_size: Cardinal): herr_t;
begin
  Result := FH5Pset_elink_file_cache_size(plist_id, efc_size);
end;

function THDF5Dll.H5Pget_elink_file_cache_size(plist_id: hid_t; efc_size: PCardinal): herr_t;
begin
  Result := FH5Pget_elink_file_cache_size(plist_id, efc_size);
end;

function THDF5Dll.H5Pset_file_image(fapl_id: hid_t; buf_ptr: Pointer; buf_len: size_t): herr_t;
begin
  Result := FH5Pset_file_image(fapl_id, buf_ptr, buf_len);
end;

function THDF5Dll.H5Pget_file_image(fapl_id: hid_t; buf_ptr_ptr: PPointer; buf_len_ptr: Psize_t): herr_t;
begin
  Result := FH5Pget_file_image(fapl_id, buf_ptr_ptr, buf_len_ptr);
end;

function THDF5Dll.H5Pset_file_image_callbacks(fapl_id: hid_t; callbacks_ptr: PH5FD_file_image_callbacks_t): herr_t;
begin
  Result := FH5Pset_file_image_callbacks(fapl_id, callbacks_ptr);
end;

function THDF5Dll.H5Pget_file_image_callbacks(fapl_id: hid_t; callbacks_ptr: PH5FD_file_image_callbacks_t): herr_t;
begin
  Result := FH5Pget_file_image_callbacks(fapl_id, callbacks_ptr);
end;

function THDF5Dll.H5Pset_core_write_tracking(fapl_id: hid_t; is_enabled: hbool_t; page_size: size_t): herr_t;
begin
  Result := FH5Pset_core_write_tracking(fapl_id, is_enabled, page_size);
end;

function THDF5Dll.H5Pget_core_write_tracking(fapl_id: hid_t; is_enabled: Phbool_t; page_size: Psize_t): herr_t;
begin
  Result := FH5Pget_core_write_tracking(fapl_id, is_enabled, page_size);
end;

function THDF5Dll.H5Pset_layout(plist_id: hid_t; layout: H5D_layout_t): herr_t;
begin
  Result := FH5Pset_layout(plist_id, layout);
end;

function THDF5Dll.H5Pget_layout(plist_id: hid_t): H5D_layout_t;
begin
  Result := FH5Pget_layout(plist_id);
end;

function THDF5Dll.H5Pset_chunk(plist_id: hid_t; ndims: Integer; dim: Phsize_t): herr_t;
begin
  Result := FH5Pset_chunk(plist_id, ndims, dim);
end;

function THDF5Dll.H5Pget_chunk(plist_id: hid_t; max_ndims: Integer; dim: Phsize_t): Integer;
begin
  Result := FH5Pget_chunk(plist_id, max_ndims, dim);
end;

function THDF5Dll.H5Pset_external(plist_id: hid_t; name: PAnsiChar; offset: off_t; size: hsize_t): herr_t;
begin
  Result := FH5Pset_external(plist_id, name, offset, size);
end;

function THDF5Dll.H5Pget_external_count(plist_id: hid_t): Integer;
begin
  Result := FH5Pget_external_count(plist_id);
end;

function THDF5Dll.H5Pget_external(plist_id: hid_t; idx: Cardinal; name_size: size_t; name: PAnsiChar; offset: Poff_t; size: Phsize_t): herr_t;
begin
  Result := FH5Pget_external(plist_id, idx, name_size, name, offset, size);
end;

function THDF5Dll.H5Pset_szip(plist_id: hid_t; options_mask: Cardinal; pixels_per_block: Cardinal): herr_t;
begin
  Result := FH5Pset_szip(plist_id, options_mask, pixels_per_block);
end;

function THDF5Dll.H5Pset_shuffle(plist_id: hid_t): herr_t;
begin
  Result := FH5Pset_shuffle(plist_id);
end;

function THDF5Dll.H5Pset_nbit(plist_id: hid_t): herr_t;
begin
  Result := FH5Pset_nbit(plist_id);
end;

function THDF5Dll.H5Pset_scaleoffset(plist_id: hid_t; scale_type: H5Z_SO_scale_type_t; scale_factor: Integer): herr_t;
begin
  Result := FH5Pset_scaleoffset(plist_id, scale_type, scale_factor);
end;

function THDF5Dll.H5Pset_fill_value(plist_id: hid_t; type_id: hid_t; value: Pointer): herr_t;
begin
  Result := FH5Pset_fill_value(plist_id, type_id, value);
end;

function THDF5Dll.H5Pget_fill_value(plist_id: hid_t; type_id: hid_t; value: Pointer): herr_t;
begin
  Result := FH5Pget_fill_value(plist_id, type_id, value);
end;

function THDF5Dll.H5Pfill_value_defined(plist: hid_t; status: PH5D_fill_value_t): herr_t;
begin
  Result := FH5Pfill_value_defined(plist, status);
end;

function THDF5Dll.H5Pset_alloc_time(plist_id: hid_t; alloc_time: H5D_alloc_time_t): herr_t;
begin
  Result := FH5Pset_alloc_time(plist_id, alloc_time);
end;

function THDF5Dll.H5Pget_alloc_time(plist_id: hid_t; alloc_time: PH5D_alloc_time_t): herr_t;
begin
  Result := FH5Pget_alloc_time(plist_id, alloc_time);
end;

function THDF5Dll.H5Pset_fill_time(plist_id: hid_t; fill_time: H5D_fill_time_t): herr_t;
begin
  Result := FH5Pset_fill_time(plist_id, fill_time);
end;

function THDF5Dll.H5Pget_fill_time(plist_id: hid_t; fill_time: PH5D_fill_time_t): herr_t;
begin
  Result := FH5Pget_fill_time(plist_id, fill_time);
end;

function THDF5Dll.H5Pset_chunk_cache(dapl_id: hid_t; rdcc_nslots: size_t; rdcc_nbytes: size_t; rdcc_w0: double): herr_t;
begin
  Result := FH5Pset_chunk_cache(dapl_id, rdcc_nslots, rdcc_nbytes, rdcc_w0);
end;

function THDF5Dll.H5Pget_chunk_cache(dapl_id: hid_t; rdcc_nslots: Psize_t; rdcc_nbytes: Psize_t; rdcc_w0: Pdouble): herr_t;
begin
  Result := FH5Pget_chunk_cache(dapl_id, rdcc_nslots, rdcc_nbytes, rdcc_w0);
end;

function THDF5Dll.H5Pset_data_transform(plist_id: hid_t; expression: PAnsiChar): herr_t;
begin
  Result := FH5Pset_data_transform(plist_id, expression);
end;

function THDF5Dll.H5Pget_data_transform(plist_id: hid_t; expression: PAnsiChar; size: size_t): ssize_t;
begin
  Result := FH5Pget_data_transform(plist_id, expression, size);
end;

function THDF5Dll.H5Pset_buffer(plist_id: hid_t; size: size_t; tconv: Pointer; bkg: Pointer): herr_t;
begin
  Result := FH5Pset_buffer(plist_id, size, tconv, bkg);
end;

function THDF5Dll.H5Pget_buffer(plist_id: hid_t; tconv: PPointer; bkg: PPointer): size_t;
begin
  Result := FH5Pget_buffer(plist_id, tconv, bkg);
end;

function THDF5Dll.H5Pset_preserve(plist_id: hid_t; status: hbool_t): herr_t;
begin
  Result := FH5Pset_preserve(plist_id, status);
end;

function THDF5Dll.H5Pget_preserve(plist_id: hid_t): Integer;
begin
  Result := FH5Pget_preserve(plist_id);
end;

function THDF5Dll.H5Pset_edc_check(plist_id: hid_t; check: H5Z_EDC_t): herr_t;
begin
  Result := FH5Pset_edc_check(plist_id, check);
end;

function THDF5Dll.H5Pget_edc_check(plist_id: hid_t): H5Z_EDC_t;
begin
  Result := FH5Pget_edc_check(plist_id);
end;

function THDF5Dll.H5Pset_filter_callback(plist_id: hid_t; func: H5Z_filter_func_t; op_data: Pointer): herr_t;
begin
  Result := FH5Pset_filter_callback(plist_id, func, op_data);
end;

function THDF5Dll.H5Pset_btree_ratios(plist_id: hid_t; left: double; middle: double; right: double): herr_t;
begin
  Result := FH5Pset_btree_ratios(plist_id, left, middle, right);
end;

function THDF5Dll.H5Pget_btree_ratios(plist_id: hid_t; left: Pdouble; middle: Pdouble; right: Pdouble): herr_t;
begin
  Result := FH5Pget_btree_ratios(plist_id, left, middle, right);
end;

function THDF5Dll.H5Pset_vlen_mem_manager(plist_id: hid_t; alloc_func: H5MM_allocate_t; alloc_info: Pointer; free_func: H5MM_free_t; free_info: Pointer): herr_t;
begin
  Result := FH5Pset_vlen_mem_manager(plist_id, alloc_func, alloc_info, free_func, free_info);
end;

function THDF5Dll.H5Pget_vlen_mem_manager(plist_id: hid_t; alloc_func: PH5MM_allocate_t; alloc_info: PPointer; free_func: PH5MM_free_t; free_info: PPointer): herr_t;
begin
  Result := FH5Pget_vlen_mem_manager(plist_id, alloc_func, alloc_info, free_func, free_info);
end;

function THDF5Dll.H5Pset_hyper_vector_size(fapl_id: hid_t; size: size_t): herr_t;
begin
  Result := FH5Pset_hyper_vector_size(fapl_id, size);
end;

function THDF5Dll.H5Pget_hyper_vector_size(fapl_id: hid_t; size: Psize_t): herr_t;
begin
  Result := FH5Pget_hyper_vector_size(fapl_id, size);
end;

function THDF5Dll.H5Pset_type_conv_cb(dxpl_id: hid_t; op: H5T_conv_except_func_t; operate_data: Pointer): herr_t;
begin
  Result := FH5Pset_type_conv_cb(dxpl_id, op, operate_data);
end;

function THDF5Dll.H5Pget_type_conv_cb(dxpl_id: hid_t; op: PH5T_conv_except_func_t; operate_data: PPointer): herr_t;
begin
  Result := FH5Pget_type_conv_cb(dxpl_id, op, operate_data);
end;

function THDF5Dll.H5Pset_create_intermediate_group(plist_id: hid_t; crt_intmd: Cardinal): herr_t;
begin
  Result := FH5Pset_create_intermediate_group(plist_id, crt_intmd);
end;

function THDF5Dll.H5Pget_create_intermediate_group(plist_id: hid_t; crt_intmd: PCardinal): herr_t;
begin
  Result := FH5Pget_create_intermediate_group(plist_id, crt_intmd);
end;

function THDF5Dll.H5Pset_local_heap_size_hint(plist_id: hid_t; size_hint: size_t): herr_t;
begin
  Result := FH5Pset_local_heap_size_hint(plist_id, size_hint);
end;

function THDF5Dll.H5Pget_local_heap_size_hint(plist_id: hid_t; size_hint: Psize_t): herr_t;
begin
  Result := FH5Pget_local_heap_size_hint(plist_id, size_hint);
end;

function THDF5Dll.H5Pset_link_phase_change(plist_id: hid_t; max_compact: Cardinal; min_dense: Cardinal): herr_t;
begin
  Result := FH5Pset_link_phase_change(plist_id, max_compact, min_dense);
end;

function THDF5Dll.H5Pget_link_phase_change(plist_id: hid_t; max_compact: PCardinal; min_dense: PCardinal): herr_t;
begin
  Result := FH5Pget_link_phase_change(plist_id, max_compact, min_dense);
end;

function THDF5Dll.H5Pset_est_link_info(plist_id: hid_t; est_num_entries: Cardinal; est_name_len: Cardinal): herr_t;
begin
  Result := FH5Pset_est_link_info(plist_id, est_num_entries, est_name_len);
end;

function THDF5Dll.H5Pget_est_link_info(plist_id: hid_t; est_num_entries: PCardinal; est_name_len: PCardinal): herr_t;
begin
  Result := FH5Pget_est_link_info(plist_id, est_num_entries, est_name_len);
end;

function THDF5Dll.H5Pset_link_creation_order(plist_id: hid_t; crt_order_flags: Cardinal): herr_t;
begin
  Result := FH5Pset_link_creation_order(plist_id, crt_order_flags);
end;

function THDF5Dll.H5Pget_link_creation_order(plist_id: hid_t; crt_order_flags: PCardinal): herr_t;
begin
  Result := FH5Pget_link_creation_order(plist_id, crt_order_flags);
end;

function THDF5Dll.H5Pset_char_encoding(plist_id: hid_t; encoding: H5T_cset_t): herr_t;
begin
  Result := FH5Pset_char_encoding(plist_id, encoding);
end;

function THDF5Dll.H5Pget_char_encoding(plist_id: hid_t; encoding: PH5T_cset_t): herr_t;
begin
  Result := FH5Pget_char_encoding(plist_id, encoding);
end;

function THDF5Dll.H5Pset_nlinks(plist_id: hid_t; nlinks: size_t): herr_t;
begin
  Result := FH5Pset_nlinks(plist_id, nlinks);
end;

function THDF5Dll.H5Pget_nlinks(plist_id: hid_t; nlinks: Psize_t): herr_t;
begin
  Result := FH5Pget_nlinks(plist_id, nlinks);
end;

function THDF5Dll.H5Pset_elink_prefix(plist_id: hid_t; prefix: PAnsiChar): herr_t;
begin
  Result := FH5Pset_elink_prefix(plist_id, prefix);
end;

function THDF5Dll.H5Pget_elink_prefix(plist_id: hid_t; prefix: PAnsiChar; size: size_t): ssize_t;
begin
  Result := FH5Pget_elink_prefix(plist_id, prefix, size);
end;

function THDF5Dll.H5Pget_elink_fapl(lapl_id: hid_t): hid_t;
begin
  Result := FH5Pget_elink_fapl(lapl_id);
end;

function THDF5Dll.H5Pset_elink_fapl(lapl_id: hid_t; fapl_id: hid_t): herr_t;
begin
  Result := FH5Pset_elink_fapl(lapl_id, fapl_id);
end;

function THDF5Dll.H5Pset_elink_acc_flags(lapl_id: hid_t; flags: Cardinal): herr_t;
begin
  Result := FH5Pset_elink_acc_flags(lapl_id, flags);
end;

function THDF5Dll.H5Pget_elink_acc_flags(lapl_id: hid_t; flags: PCardinal): herr_t;
begin
  Result := FH5Pget_elink_acc_flags(lapl_id, flags);
end;

function THDF5Dll.H5Pset_elink_cb(lapl_id: hid_t; func: H5L_elink_traverse_t; op_data: Pointer): herr_t;
begin
  Result := FH5Pset_elink_cb(lapl_id, func, op_data);
end;

function THDF5Dll.H5Pget_elink_cb(lapl_id: hid_t; func: PH5L_elink_traverse_t; op_data: PPointer): herr_t;
begin
  Result := FH5Pget_elink_cb(lapl_id, func, op_data);
end;

function THDF5Dll.H5Pset_copy_object(plist_id: hid_t; crt_intmd: Cardinal): herr_t;
begin
  Result := FH5Pset_copy_object(plist_id, crt_intmd);
end;

function THDF5Dll.H5Pget_copy_object(plist_id: hid_t; crt_intmd: PCardinal): herr_t;
begin
  Result := FH5Pget_copy_object(plist_id, crt_intmd);
end;

function THDF5Dll.H5Padd_merge_committed_dtype_path(plist_id: hid_t; path: PAnsiChar): herr_t;
begin
  Result := FH5Padd_merge_committed_dtype_path(plist_id, path);
end;

function THDF5Dll.H5Pfree_merge_committed_dtype_paths(plist_id: hid_t): herr_t;
begin
  Result := FH5Pfree_merge_committed_dtype_paths(plist_id);
end;

function THDF5Dll.H5Pset_mcdt_search_cb(plist_id: hid_t; func: H5O_mcdt_search_cb_t; op_data: Pointer): herr_t;
begin
  Result := FH5Pset_mcdt_search_cb(plist_id, func, op_data);
end;

function THDF5Dll.H5Pget_mcdt_search_cb(plist_id: hid_t; func: PH5O_mcdt_search_cb_t; op_data: PPointer): herr_t;
begin
  Result := FH5Pget_mcdt_search_cb(plist_id, func, op_data);
end;

end.

