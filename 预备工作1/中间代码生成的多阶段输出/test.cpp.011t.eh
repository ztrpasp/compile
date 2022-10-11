
;; Function cal_area (_Z8cal_areaf, funcdef_no=1751, decl_uid=41283, cgraph_uid=597, symbol_order=599)

cal_area (float r)
{
  float D.44971;

  _1 = std::pow<float, int> (r, 2);
  _2 = _1 * 3.140000000000000124344978758017532527446746826171875e+0;
  D.44971 = (float) _2;
  goto <D.44972>;
  <D.44972>:
  return D.44971;
}



;; Function std::pow<float, int> (_ZSt3powIfiEN9__gnu_cxx11__promote_2IT_T0_NS0_9__promoteIS2_XsrSt12__is_integerIS2_E7__valueEE6__typeENS4_IS3_XsrS5_IS3_E7__valueEE6__typeEE6__typeES2_S3_, funcdef_no=1752, decl_uid=41293, cgraph_uid=596, symbol_order=598)

std::pow<float, int> (float __x, int __y)
{
  __type D.44973;

  _1 = (double) __y;
  _2 = (double) __x;
  D.44973 = pow (_2, _1);
  goto <D.44974>;
  <D.44974>:
  return D.44973;
}



;; Function cal_perimeter (_Z13cal_perimeterf, funcdef_no=1753, decl_uid=41310, cgraph_uid=598, symbol_order=600)

cal_perimeter (float r)
{
  float D.44975;

  _1 = (double) r;
  _2 = _1 * 6.28000000000000024868995751603506505489349365234375e+0;
  D.44975 = (float) _2;
  goto <D.44976>;
  <D.44976>:
  return D.44975;
}



;; Function main (main, funcdef_no=1754, decl_uid=41312, cgraph_uid=599, symbol_order=601)

main ()
{
  struct __ostream_type & D.44982;
  float D.44981;
  float area;
  int i;
  int n;
  int D.44979;

  std::basic_istream<char>::operator>> (&cin, &n);
  i = 1;
  <D.44977>:
  n.0_1 = n;
  if (i > n.0_1) goto <D.41365>; else goto <D.44978>;
  <D.44978>:
  _2 = (float) i;
  D.44981 = cal_area (_2);
  area = D.44981;
  D.44982 = std::basic_ostream<char>::operator<< (&cout, area);
  _3 = D.44982;
  std::basic_ostream<char>::operator<< (_3, endl);
  goto <D.44977>;
  <D.41365>:
  D.44979 = 0;
  goto <D.44984>;
  <D.44984>:
  n = {CLOBBER};
  goto <D.44980>;
  D.44979 = 0;
  goto <D.44980>;
  <D.44980>:
  return D.44979;
  <D.44983>:
  n = {CLOBBER};
  resx 1
}



;; Function __static_initialization_and_destruction_0 (_Z41__static_initialization_and_destruction_0ii, funcdef_no=2241, decl_uid=44963, cgraph_uid=1086, symbol_order=1112)

__static_initialization_and_destruction_0 (int __initialize_p, int __priority)
{
  if (__initialize_p == 1) goto <D.44986>; else goto <D.44987>;
  <D.44986>:
  if (__priority == 65535) goto <D.44988>; else goto <D.44989>;
  <D.44988>:
  std::ios_base::Init::Init (&__ioinit);
  __cxa_atexit (__dt_comp , &__ioinit, &__dso_handle);
  goto <D.44990>;
  <D.44989>:
  <D.44990>:
  goto <D.44991>;
  <D.44987>:
  <D.44991>:
  return;
}



;; Function _GLOBAL__sub_I__Z8cal_areaf (_GLOBAL__sub_I__Z8cal_areaf, funcdef_no=2242, decl_uid=44969, cgraph_uid=1087, symbol_order=1242)

_GLOBAL__sub_I__Z8cal_areaf ()
{
  __static_initialization_and_destruction_0 (1, 65535);
  return;
}


