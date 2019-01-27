/*
 * Code for class APPLICATION
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"


#ifdef __cplusplus
extern "C" {
#endif

extern EIF_TYPED_VALUE F958_7139(EIF_REFERENCE);
extern EIF_TYPED_VALUE F958_7165(EIF_REFERENCE);
extern EIF_TYPED_VALUE F958_7704(EIF_REFERENCE);
extern void F958_7102(EIF_REFERENCE);
extern void EIF_Minit958(void);

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {APPLICATION}.comm */
EIF_TYPED_VALUE F958_7139 (EIF_REFERENCE Current)
{
	EIF_TYPED_VALUE r;
	r.type = SK_REF;
	r.it_r = *(EIF_REFERENCE *)(Current + RTWA(4974,Dtype(Current)));
	return r;
}


/* {APPLICATION}.dict */
EIF_TYPED_VALUE F958_7165 (EIF_REFERENCE Current)
{
	EIF_TYPED_VALUE r;
	r.type = SK_REF;
	r.it_r = *(EIF_REFERENCE *)(Current + RTWA(4999,Dtype(Current)));
	return r;
}


/* {APPLICATION}.t */
EIF_TYPED_VALUE F958_7704 (EIF_REFERENCE Current)
{
	EIF_TYPED_VALUE r;
	r.type = SK_REF;
	r.it_r = *(EIF_REFERENCE *)(Current + RTWA(5435,Dtype(Current)));
	return r;
}


/* {APPLICATION}.make */
void F958_7102 (EIF_REFERENCE Current)
{
	GTCX
	char *l_feature_name = "make";
	RTEX;
	EIF_TYPED_VALUE up1x = {{0}, SK_POINTER};
#define up1 up1x.it_p
	EIF_TYPED_VALUE ur1x = {{0}, SK_REF};
#define ur1 ur1x.it_r
	EIF_TYPED_VALUE ui4_1x = {{0}, SK_INT32};
#define ui4_1 ui4_1x.it_i4
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_REFERENCE tr3 = NULL;
	EIF_REFERENCE tr4 = NULL;
	EIF_INTEGER_32 ti4_1;
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	RTLI(6);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,ur1);
	RTLR(3,tr2);
	RTLR(4,tr3);
	RTLR(5,tr4);
	RTLIU(6);
	RTLU (SK_VOID, NULL);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 957, Current, 0, 0, 13375);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 0);
	RTGC;
	RTDBGEAA(957, Current, 13375);
	RTIV(Current, RTAL);
	RTHOOK(1);
	RTDBGAA(Current, dtype, 5435, 0xF80003D9, 0); /* t */
	tr1 = RTLNSMART(RTWCT(5435, dtype, Dftype(Current)).id);
	(FUNCTION_CAST(void, (EIF_REFERENCE)) RTWC(5353, Dtype(tr1)))(tr1);
	RTNHOOK(1,1);
	tr1 = RTCCL(tr1);
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current + RTWA(5435, dtype)) = (EIF_REFERENCE) tr1;
	RTHOOK(2);
	tr1 = ((up1x = (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTWF(5435, dtype))(Current)), (((up1x.type & SK_HEAD) == SK_REF)? (EIF_REFERENCE) 0: (up1x.it_r = RTBU(up1x))), (up1x.type = SK_POINTER), up1x.it_r);
	RTNHOOK(2,1);
	ti4_1 = (((FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTVF(5100, "nano_second", tr1))(tr1)).it_i4);
	ur1 = RTLN(eif_new_type(217, 0x00).id);
	*(EIF_INTEGER_32 *)ur1 = ti4_1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(30, dtype))(Current, ur1x);
	RTHOOK(3);
	tr1 = RTMS_EX_H("\012",1,10);
	ur1 = tr1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(30, dtype))(Current, ur1x);
	RTHOOK(4);
	tr1 = ((up1x = (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTWF(5435, dtype))(Current)), (((up1x.type & SK_HEAD) == SK_REF)? (EIF_REFERENCE) 0: (up1x.it_r = RTBU(up1x))), (up1x.type = SK_POINTER), up1x.it_r);
	RTNHOOK(4,1);
	ti4_1 = (((FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTVF(5100, "nano_second", tr1))(tr1)).it_i4);
	ur1 = RTLN(eif_new_type(217, 0x00).id);
	*(EIF_INTEGER_32 *)ur1 = ti4_1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(30, dtype))(Current, ur1x);
	RTHOOK(5);
	RTDBGAA(Current, dtype, 4999, 0xF80003BF, 0); /* dict */
	tr1 = RTLNSMART(RTWCT(4999, dtype, Dftype(Current)).id);
	ui4_1 = ((EIF_INTEGER_32) 6L);
	{
		static EIF_TYPE_INDEX typarr0[] = {340,0xFF01,231,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr3 = RTLNSP2(typres0.id,EO_REF,ui4_1,sizeof(EIF_REFERENCE), EIF_FALSE);
		RT_SPECIAL_COUNT(tr3) = 6L;
		memset(tr3, 0, RT_SPECIAL_VISIBLE_SIZE(tr3));
	}
	tr4 = RTMS_EX_H("integer",7,1079669874);
	*((EIF_REFERENCE *)tr3+0) = (EIF_REFERENCE) tr4;
	RTAR(tr3,tr4);
	tr4 = RTMS_EX_H("hello",5,1702403183);
	*((EIF_REFERENCE *)tr3+1) = (EIF_REFERENCE) tr4;
	RTAR(tr3,tr4);
	tr4 = RTMS_EX_H("cat",3,6513012);
	*((EIF_REFERENCE *)tr3+2) = (EIF_REFERENCE) tr4;
	RTAR(tr3,tr4);
	tr4 = RTMS_EX_H("word",4,2003792484);
	*((EIF_REFERENCE *)tr3+3) = (EIF_REFERENCE) tr4;
	RTAR(tr3,tr4);
	tr4 = RTMS_EX_H("innopolis",9,1394865267);
	*((EIF_REFERENCE *)tr3+4) = (EIF_REFERENCE) tr4;
	RTAR(tr3,tr4);
	tr4 = RTMS_EX_H("eiffel",6,1917367148);
	*((EIF_REFERENCE *)tr3+5) = (EIF_REFERENCE) tr4;
	RTAR(tr3,tr4);
	tr2 = (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE))  RTWF(2634, Dtype(tr3)))(tr3).it_r;
	ur1 = tr2;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWC(4985, Dtype(tr1)))(tr1, ur1x);
	RTNHOOK(5,1);
	tr1 = RTCCL(tr1);
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current + RTWA(4999, dtype)) = (EIF_REFERENCE) tr1;
	RTHOOK(6);
	RTDBGAA(Current, dtype, 4974, 0xF80003BE, 0); /* comm */
	tr1 = RTLNSMART(RTWCT(4974, dtype, Dftype(Current)).id);
	tr2 = ((up1x = (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTWF(4999, dtype))(Current)), (((up1x.type & SK_HEAD) == SK_REF)? (EIF_REFERENCE) 0: (up1x.it_r = RTBU(up1x))), (up1x.type = SK_POINTER), up1x.it_r);
	ur1 = RTCCL(tr2);
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWC(4962, Dtype(tr1)))(tr1, ur1x);
	RTNHOOK(6,1);
	tr1 = RTCCL(tr1);
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current + RTWA(4974, dtype)) = (EIF_REFERENCE) tr1;
	RTHOOK(7);
	tr1 = ((up1x = (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTWF(4974, dtype))(Current)), (((up1x.type & SK_HEAD) == SK_REF)? (EIF_REFERENCE) 0: (up1x.it_r = RTBU(up1x))), (up1x.type = SK_POINTER), up1x.it_r);
	RTNHOOK(7,1);
	(FUNCTION_CAST(void, (EIF_REFERENCE)) RTVF(4972, "start", tr1))(tr1);
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(8);
	RTDBGLE;
	RTMD(0);
	RTLE;
	RTLO(2);
	RTEE;
#undef up1
#undef ur1
#undef ui4_1
}

void EIF_Minit958 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
