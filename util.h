#ifndef UTIL_H
#define UTIL_H

#include "soapH.h"
#include <netinet/in.h>
#include <ifaddrs.h>

#ifndef noprintf
extern void noprintf(char *format, ...);
#endif
   
#define _DEUBG_
#ifdef _DEUBG_
	#define DBG printf
#else
	#define DBG noprintf
#endif

#define MULTICAST_ADDR "239.255.255.250"
#define MULTICAST_PORT 3702
#define NET_MAX_INTERFACE 4

#ifdef __APPLE__
#define INTERFACE_NAME_1 "en0"
#define INTERFACE_NAME_2 "en1"
#else
#define INTERFACE_NAME_1 "eth0"
#define INTERFACE_NAME_2 "eth1"
#endif
// Network

extern struct sockaddr_in gMSockAddr;
extern char gpLocalAddr[NET_MAX_INTERFACE][32];

extern int CreateMulticastClient(char *pAddress, int port);
extern int CreateMulticastServer(void);
extern int CreateUnicastClient(struct sockaddr_in *pSockAddr);

// Xml send callback
extern void clearXmlBuffer(void);
extern int mysend(struct soap *soap, const char *s, size_t n);
extern char* getXmlBufferData(void);

extern void * MyMalloc(int vSize);
extern void MyFree(void *ptr);
extern char * MySoapCopyString(struct soap *pSoap, char *pSrc);

extern char * CopyString(char *pSrc);
extern char * getMyIpString(char *pInterfaceName);
extern char * initMyIpString(void);
extern char * getMyMacAddress(void);



extern int match_rfc3986(char *pItem);
extern int match_uuid(char *pItem);
extern int match_ldap(char *pItem);
extern int match_strcmp0(char *pItem);
extern int match_none(char *pItem);


extern void InitMyRandom(char *myipaddr);
extern long our_random() ;
extern unsigned int our_random16();
extern unsigned int our_random32();
extern void UuidGen(char *uuidbuf);

#endif

