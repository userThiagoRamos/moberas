import * as functions from 'firebase-functions'

export default async (
    event: functions.analytics.AnalyticsEvent,
    context: functions.EventContext
) => {
    console.log(event)
    return null
}