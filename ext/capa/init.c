#include "ruby.h"
#include <assert.h>

#define ARY_DEFAULT_SIZE 16
#define ARY_EMBED_P(ary) \
  (assert(!FL_TEST((ary), ELTS_SHARED) || !FL_TEST((ary), RARRAY_EMBED_FLAG)), \
  FL_TEST((ary), RARRAY_EMBED_FLAG)!=0)
#define ARY_SHARED_ROOT_P(ary) (FL_TEST((ary), RARRAY_SHARED_ROOT_FLAG))
# define ARY_SHARED_P(ary) \
  (assert(!FL_TEST((ary), ELTS_SHARED) || !FL_TEST((ary), RARRAY_EMBED_FLAG)), \
  FL_TEST((ary),ELTS_SHARED)!=0)
#define ARY_SHARED(ary) (assert(ARY_SHARED_P(ary)), RARRAY(ary)->as.heap.aux.shared)
#define ARY_CAPA(ary) (ARY_EMBED_P(ary) ? RARRAY_EMBED_LEN_MAX : \
  ARY_SHARED_ROOT_P(ary) ? RARRAY_LEN(ary) : RARRAY(ary)->as.heap.aux.capa)
#define RARRAY_SHARED_ROOT_FLAG FL_USER5

static VALUE
rb_s_ary_new_capa(VALUE klass, VALUE capa)
{
  return rb_ary_new_capa(FIX2LONG(capa));
}

static VALUE
rb_ary_capa(VALUE self)
{
  if (ARY_SHARED_P(self)) {
    return LONG2FIX(RARRAY_LEN(ARY_SHARED(self)));
  }
  return LONG2FIX(ARY_CAPA(self));
}

void
Init_ext()
{
  rb_define_singleton_method(rb_cArray, "new_capa", rb_s_ary_new_capa, 1);
  rb_define_method(rb_cArray, "capa", rb_ary_capa, 0);
  rb_define_const(rb_cArray, "DEFAULT_SIZE", INT2FIX(ARY_DEFAULT_SIZE));
}
