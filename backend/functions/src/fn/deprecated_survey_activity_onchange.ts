import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();
const firestote = admin.firestore();
export default async (
  change: functions.Change<functions.firestore.DocumentSnapshot>,
  context: functions.EventContext
) => {
  const uid = context.params.uid0;
  const aid = context.params.aid;
  const docPath = change.after.ref.path;
  const activityCollectionPath = docPath.replace(`/${aid}`, "");
  const activityCollectionRef = firestote.collection(activityCollectionPath);

  const activityOnDisplayDocs = await activityCollectionRef
    .where("display", "==", true)
    .get();
  if (activityOnDisplayDocs.empty) {
    await firestote
      .doc(`users/${uid}/private_profile/${uid}/survey/${uid}`)
      .set({ dynamicOnDisplay: false }, { merge: true });
  }
  return true;
};
