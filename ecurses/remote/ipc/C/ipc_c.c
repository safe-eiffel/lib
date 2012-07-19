#include "ipc_c.h"

/* Common functions */

EIF_INTEGER ipc_wait_for_lock (EIF_INTEGER a_handle) {
	return (EIF_INTEGER) WaitForSingleObject ((HANDLE) a_handle, INFINITE);
}

EIF_INTEGER ipc_close (EIF_INTEGER a_handle) {
	return (EIF_INTEGER) CloseHandle ((HANDLE) a_handle);
}

/* Mutex */

EIF_INTEGER ipc_mutex_create_and_lock (EIF_POINTER lpName) {
	return (EIF_INTEGER) CreateMutex (NULL, TRUE, (LPCTSTR)lpName);
}

EIF_INTEGER ipc_mutex_create (EIF_POINTER lpName) {
	return (EIF_INTEGER) CreateMutex (NULL, FALSE, (LPCTSTR)lpName);
}

EIF_INTEGER ipc_mutex_release (EIF_INTEGER a_handle) {
	return (EIF_INTEGER) ReleaseMutex ((HANDLE) a_handle);
}

EIF_INTEGER ipc_mutex_open (EIF_POINTER lpName) {
	return (EIF_INTEGER) OpenMutex (MUTEX_ALL_ACCESS, TRUE, (LPCTSTR)lpName);
}


/* Semaphores */

EIF_INTEGER ipc_semaphore_create (EIF_INTEGER lInitialCount, EIF_INTEGER lMaximumCount, EIF_POINTER lpName){
	return (EIF_INTEGER) CreateSemaphore (NULL, (LONG) lInitialCount, (LONG) lMaximumCount, (LPCTSTR) lpName);
} 

EIF_INTEGER ipc_semaphore_open (EIF_POINTER lpName) {
	return (EIF_INTEGER) OpenSemaphore (SEMAPHORE_ALL_ACCESS, TRUE, (LPCTSTR)lpName);
}

EIF_INTEGER ipc_semaphore_release (EIF_INTEGER a_handle, EIF_INTEGER lReleaseCount) {
	return (EIF_INTEGER) ReleaseSemaphore ((HANDLE) a_handle, (LONG)lReleaseCount, NULL );
}

 
/* Shared memory */

EIF_INTEGER ipc_create_file_mapping (EIF_INTEGER dwMaximumSizeHigh, EIF_INTEGER dwMaximumSizeLow, EIF_POINTER lpName) {
	return (EIF_INTEGER) CreateFileMapping ((HANDLE) 0xFFFFFFFF, NULL, PAGE_READWRITE, dwMaximumSizeHigh, dwMaximumSizeLow, (LPCTSTR) lpName);
}

EIF_POINTER ipc_map_view_of_file (EIF_INTEGER hFileMappingObject, EIF_INTEGER dwNumberOfBytesToMap) {
	return (EIF_POINTER) MapViewOfFile((HANDLE) hFileMappingObject, FILE_MAP_WRITE, (DWORD) 0, (DWORD) 0, (DWORD) dwNumberOfBytesToMap);
}
 
EIF_INTEGER ipc_unmap_view_of_file (EIF_POINTER lpBaseAddress) {
	return (EIF_INTEGER) UnmapViewOfFile ((LPCVOID) lpBaseAddress);
}

void ipc_shared_memory_put (EIF_POINTER lpBaseAddress, EIF_POINTER a_string){
	lstrcpy ((LPTSTR)lpBaseAddress, (LPCTSTR)a_string);
}

EIF_POINTER ipc_shared_memory_item (EIF_POINTER lpBaseAddress) {
	LPTSTR lpOut;
	wsprintf (lpOut, "%s", (LPCTSTR) lpBaseAddress);
	return (EIF_POINTER) lpOut;  
}

EIF_INTEGER ipc_open_file_mapping (EIF_POINTER lpName) {
	return (EIF_INTEGER) OpenFileMapping (FILE_MAP_WRITE, TRUE, (LPCTSTR) lpName);
}
  
  
  
  
