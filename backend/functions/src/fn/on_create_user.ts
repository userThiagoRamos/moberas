import * as admin from "firebase-admin";
import { EventContext } from "firebase-functions";
import { handleError, validateUser } from ".././fn/shared/sharedFn";
admin.initializeApp();

export default async (user: admin.auth.UserRecord, context: EventContext) => {
  validateUser(user);
  const uid = user.uid;
  try {
    if (!user.email!.includes('admin')) {
      console.log(`Registrando paciente ${user.email}`);

      const resultPromiseArray = await Promise.all([admin
        .firestore()
        .doc("preferences/textTheme")
        .get(), admin
          .firestore()
          .collection("milestones")
          .get(), admin
            .firestore()
            .collection("activities")
            .get()]);

      const preferencesTemplate = resultPromiseArray[0];
      const milestonesTemplate = resultPromiseArray[1];
      const activitiesTemplate = resultPromiseArray[2];

      const appUser = {
        uid: uid,
        createdAt: admin.firestore.Timestamp.now(),
        showIntroVideo: true,
      };

      await admin.firestore().doc(`users/${uid}`).set(appUser, { merge: true });

      if (preferencesTemplate.exists) {
        await admin
          .firestore()
          .doc(`users/${uid}/private_profile/${uid}/preferences/theme`)
          .set({ ...preferencesTemplate.data() }, { merge: true });
      }

      const batch = admin.firestore().batch();

      const milestonesRef = admin
        .firestore()
        .collection(
          `users/${uid}/private_profile/${uid}/survey/${uid}/milestones`
        );
      const activityRef = admin
        .firestore()
        .collection(
          `users/${uid}/private_profile/${uid}/survey/${uid}/activities/`
        );

      let milestoneData;
      if (!milestonesTemplate.empty) {
        milestonesTemplate.docs.forEach((mDOC) => {
          milestoneData = {
            display: true,
            ...mDOC.data(),
          };
          batch.set(milestonesRef.doc(mDOC.id), milestoneData, { merge: true });
        });
      }

      let activityData;
      if (!activitiesTemplate.empty) {
        activitiesTemplate.docs.forEach(async (aDOC) => {
          activityData = {
            display: false,
            ...aDOC.data(),
          };
          batch.set(activityRef.doc(aDOC.id), activityData, { merge: true });
        });
      }

      batch.set(
        admin
          .firestore()
          .doc(`users/${uid}/private_profile/${uid}/survey/${uid}`),
        { dynamicOnDisplay: false, milestoneOnDisplay: true },
        { merge: true }
      );

      await batch.commit();
    } else {
      console.log(`Registrando admin ${user.email}`);
      const username = user.email?.split("@")[0];
      const adminUser = {
        displayName: username || "anônimo",
        uid: uid,
        createdAt: admin.firestore.Timestamp.now(),
      };
      await admin.firestore().doc(`admins/${uid}`).set(adminUser, { merge: true });
    }
  } catch (error) {
    handleError("on-user-create", error);
  }
};
