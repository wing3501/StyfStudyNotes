////
////  KSUserDump.m
////  StyfStudyNotes
////
////  Created by styf on 2021/11/23.
////
//
//#import "KSUserDump.h"
//#import "KSJSONCodecObjC.h"
//#include "KSLogger.h"
//#include "KSID.h"
//#include "KSMachineContext.h"
//#include "KSThread.h"
//#include "KSStackCursor_SelfThread.h"
//#include "KSCrashMonitorContext.h"
//#include "KSFileUtils.h"
//#include "KSCrashReportStore.h"
//#include "KSCrashReportFields.h"
//#include "KSCrashReportVersion.h"
//#include "KSJSONCodec.h"
//#include "KSCrashReportWriter.h"
//#include "KSCrashReport.h"
//
//@implementation KSUserDump
//
//void kscm_handleException(struct KSCrash_MonitorContext* monitorContext)
//{
//    char crashReportFilePath[KSFU_MAX_PATH_LENGTH];
//    int64_t reportID = kscrs_getNextCrashReport(crashReportFilePath);
//    strncpy(g_lastCrashReportFilePath, crashReportFilePath, sizeof(g_lastCrashReportFilePath));
//    kscrashreport_writeStandardReport(monitorContext, crashReportFilePath);
//
//    if(g_reportWrittenCallback)
//    {
//        g_reportWrittenCallback(reportID);
//    }
//}
//
//void kscm_reportUserException(const char* name,
//                              const char* reason,
//                              const char* language,
//                              const char* lineOfCode,
//                              const char* stackTrace,
//                              bool logAllThreads,
//                              bool terminateProgram,
//                              const char* dumpFilePath)
//{
//    thread_act_array_t threads = NULL;
//    mach_msg_type_number_t numThreads = 0;
//    if(logAllThreads)
//    {
//        ksmc_suspendEnvironment(&threads, &numThreads);
//    }
////    if(terminateProgram)
////    {
////        kscm_notifyFatalExceptionCaptured(false);
////    }
//
//    char eventID[37];
//    ksid_generate(eventID);
//    KSMC_NEW_CONTEXT(machineContext);
//    ksmc_getContextForThread(ksthread_self(), machineContext, true);
//    KSStackCursor stackCursor;
//    kssc_initSelfThread(&stackCursor, 0);
//
//
//    KSLOG_DEBUG("Filling out context.");
//    KSCrash_MonitorContext context;
//    memset(&context, 0, sizeof(context));
//    context.crashType = KSCrashMonitorTypeUserReported;
//    context.eventID = eventID;
//    context.offendingMachineContext = machineContext;
//    context.registersAreValid = false;
//    context.crashReason = reason;
//    context.userException.name = name;
//    context.userException.language = language;
//    context.userException.lineOfCode = lineOfCode;
//    context.userException.customStackTrace = stackTrace;
//    context.stackCursor = &stackCursor;
//
//    kscm_handleException(&context);
//
//    if(logAllThreads)
//    {
//        ksmc_resumeEnvironment(threads, numThreads);
//    }
//    if(terminateProgram)
//    {
//        abort();
//    }
//}
//
///** Report a custom, user defined exception.
// * This can be useful when dealing with scripting languages.
// *
// * If terminateProgram is true, all sentries will be uninstalled and the application will
// * terminate with an abort().
// *
// * @param name The exception name (for namespacing exception types).
// *
// * @param reason A description of why the exception occurred.
// *
// * @param language A unique language identifier.
// *
// * @param lineOfCode A copy of the offending line of code (nil = ignore).
// *
// * @param stackTrace An array of frames (dictionaries or strings) representing the call stack leading to the exception (nil = ignore).
// *
// * @param logAllThreads If true, suspend all threads and log their state. Note that this incurs a
// *                      performance penalty, so it's best to use only on fatal errors.
// *
// * @param terminateProgram If true, do not return from this function call. Terminate the program instead.
// *
// * @param dumpFilePath 导出路径
// */
//- (void) reportUserException:(NSString*) name
//                      reason:(NSString*) reason
//                    language:(NSString*) language
//                  lineOfCode:(NSString*) lineOfCode
//                  stackTrace:(NSArray*) stackTrace
//               logAllThreads:(BOOL) logAllThreads
//            terminateProgram:(BOOL) terminateProgram
//                dumpFilePath:(const char *) dumpFilePath {
//    const char* cName = [name cStringUsingEncoding:NSUTF8StringEncoding];
//    const char* cReason = [reason cStringUsingEncoding:NSUTF8StringEncoding];
//    const char* cLanguage = [language cStringUsingEncoding:NSUTF8StringEncoding];
//    const char* cLineOfCode = [lineOfCode cStringUsingEncoding:NSUTF8StringEncoding];
//    const char* cStackTrace = NULL;
//    if(stackTrace != nil)
//    {
//        NSError* error = nil;
//        NSData* jsonData = [KSJSONCodec encode:stackTrace options:0 error:&error];
//        if(jsonData == nil || error != nil)
//        {
//            KSLOG_ERROR(@"Error encoding stack trace to JSON: %@", error);
//            // Don't return, since we can still record other useful information.
//        }
//        NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        cStackTrace = [jsonString cStringUsingEncoding:NSUTF8StringEncoding];
//    }
//    kscm_reportUserException(cName,
//                                cReason,
//                                cLanguage,
//                                cLineOfCode,
//                                cStackTrace,
//                                logAllThreads,
//                                terminateProgram,
//                                dumpFilePath);
//}
//@end
