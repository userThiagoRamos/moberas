export function handleError(method: string, message: string, error?: Error) {
  throw new Error(
    `methodName: ${method} - message: ${error ? error.message : message} `
  );
}

export function validateUser(
  user: import("firebase-admin/lib/auth").admin.auth.UserRecord
): void {
  if (user.disabled || user.uid === null) {
    throw new Error("User is not valid.");
  }
}
