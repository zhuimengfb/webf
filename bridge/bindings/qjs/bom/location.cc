/*
 * Copyright (C) 2019-2022 The Kraken authors. All rights reserved.
 * Copyright (C) 2022-present The WebF authors. All rights reserved.
 */

#include "location.h"
#include <utility>
#include "dart_methods.h"

namespace webf::binding::qjs {

JSValue Location::reload(JSContext* ctx, JSValue this_val, int argc, JSValue* argv) {
  auto* location = static_cast<Location*>(JS_GetOpaque(this_val, ExecutionContext::kHostObjectClassId));
  if (getDartMethod()->reloadApp == nullptr) {
    return JS_ThrowTypeError(ctx, "Failed to execute 'reload': dart method (reloadApp) is not registered.");
  }

  getDartMethod()->flushUICommand();
  getDartMethod()->reloadApp(location->m_context->getContextId());

  return JS_NULL;
}

}  // namespace webf::binding::qjs
