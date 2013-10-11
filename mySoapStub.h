#ifndef MYSOAPSTUB_H
#define MYSOAPSTUB_H

#include "soapH.h"
#include <netinet/in.h>
#include <ifaddrs.h>

// Below 4 message is send as multicast packet
extern int SendHello(int socket, char *pXAddrs);
extern int SendBye(int socket, char *pXAddrs);
extern int SendProbe(int socket);
extern int SendResolve(int socket);
extern int SendFault(int socket, struct sockaddr_in *pSockAddr_In);


// The response should be send to the multicast sender as unicast packet
extern int SendProbeMatches(int socket, struct sockaddr_in *pSockAddr_In, char *pSenderMsgId);
extern int SendResolveMatches(int socket, struct sockaddr_in *pSockAddr_In, char *pSenderMsgId);

#endif
