import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
admin.initializeApp();
const firestote = admin.firestore();
export default async (
  change: functions.Change<functions.firestore.DocumentSnapshot>,
  context: functions.EventContext
) => {
  const surveyPath = change.after.ref.path;
  console.log(surveyPath);

  const afterData = change.after.data();
  const beforeData = change.before.data();
  const batch = firestote.batch();

  if (
    beforeData!.dynamicOnDisplay === false &&
    afterData!.dynamicOnDisplay === true
  ) {
    const activitiesPath = surveyPath.concat(`/activities`);
    const activitiesDocs = await firestote.collection(activitiesPath).orderBy('order','asc').get();
    activitiesDocs.forEach((doc) => {
        batch.set(doc.ref, { display: false }, { merge: true });
    });
    batch.set(activitiesDocs.docs[0].ref, { display: true }, { merge: true });
  }

  if (
    beforeData!.milestoneOnDisplay === false &&
    afterData!.milestoneOnDisplay === true
  ) {
    const milestonePath = surveyPath.concat(`/milestones`);
    const milestoneDocs = await firestote.collection(milestonePath).get();
    milestoneDocs.forEach((doc) => {
      batch.set(doc.ref, { display: true }, { merge: true });
    });
  }

  return await batch.commit();
};
