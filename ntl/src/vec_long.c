
#include <NTL/vec_long.h>

#include <NTL/new.h>

NTL_START_IMPL

inline void BlockConstruct(long *, long) { }
inline void BlockDestroy(long *, long) { }

NTL_vector_impl_plain(long,vec_long)

NTL_eq_vector_impl(long,vec_long)

NTL_END_IMPL

