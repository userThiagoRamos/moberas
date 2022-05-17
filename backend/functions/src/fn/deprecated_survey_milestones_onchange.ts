import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();
const firestote = admin.firestore();

export default async (
  change: functions.Change<functions.firestore.DocumentSnapshot>,
  context: functions.EventContext
) => {
  const uid = context.params.uid0;
  const mid = context.params.mid;
  const docPath = change.after.ref.path;
  const milestoneCollectionPath = docPath.replace(`/${mid}`, "");
  const milestoneCollectionRef = firestote.collection(milestoneCollectionPath);

  const milestoneOnDisplayDocs = await milestoneCollectionRef
    .where("display", "==", true)
    .get();
  if (milestoneOnDisplayDocs.empty) {
    await firestote
      .doc(`users/${uid}/private_profile/${uid}/survey/${uid}`)
      .set({ milestoneOnDisplay: false }, { merge: true });
  }
  return true;
};
