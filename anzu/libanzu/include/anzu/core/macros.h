#pragma once
#ifndef ANZU_CORE_MACROS_H
#define ANZU_CORE_MACROS_H

// This file contains minimal, required suite of macros for API tagging in more cross-compile manner

#if (defined WIN32 || defined _WIN32 || defined WINCE || defined __CYGWIN__)
#define ANZU_EXPORT __declspec(dllexport)
#elif defined __GNUC__ && __GNUC__ >= 4
#define ANZU_EXPORT __attribute__((visibility("default")))
#else
#define ANZU_EXPORT
#endif

#ifdef __GNUC__
#define ANZU_DEPRECATED(func) func __attribute__((deprecated))
#elif defined(_MSC_VER)
#define ANZU_DEPRECATED(func) __declspec(deprecated) func
#else
#pragma message("WARNING: You need to implement DEPRECATED for this compiler")
#define ANZU_DEPRECATED(func) func
#endif

#endif // ANZU_CORE_MACROS_H
