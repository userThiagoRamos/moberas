import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
import { getMilestoneAnswerPoints } from './shared/score_service';
admin.initializeApp();

export default async (
    change: functions.Change<functions.firestore.DocumentSnapshot>,
    context: functions.EventContext
) => {

    const answer = change.after.data();
    const uid = context.params.uid;
    const questionName = answer!.milestone.name;
    const score = getMilestoneAnswerPoints(questionName);
    const increment = admin.firestore.FieldValue.increment(score);

    return admin.firestore().doc(`users/${uid}`).update({'score':increment});
}