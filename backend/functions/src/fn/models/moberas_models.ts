export interface ISurveyResponses{

selectedValue: string;

}

export interface IActivity{
    name: string;
    question: string;
    scale: string;
    order: number;
}

export interface IResponse{
    activity: IActivity;
    response: ISurveyResponses;
    date_time: any;
}