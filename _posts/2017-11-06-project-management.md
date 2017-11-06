---
layout: post
title:  Project management
date:   2017-11-06
categories: project management portfolio program
---

The following are notes on project management basics.
They are mostly well-known best practices but I took inspiration from _Successful Project Management_, by Trevor L. Young.
I divided the contents into two main part, the first is about the context of a project, the enterprise and basic definitions.
The second part is focused on the proper project management.

## Part 1 - Project Context
The following is focused on organization of projects in an enterprise.
### Enterprise organization
Organizations have a vision of how to tackle a certain mission.
They also have strategies to address those missions.

$$ \text{vision}, \text{mission} \implies \text{strategies} $$

The organization directors (high-level managers) form a committee, which steers the organization strategies to best address the mission.
Each of these director can work as _sponsor_, the supporter of a particular project. 
This role is different from the project manager and it is more high level, strategy-related; its duties include picking the project manager, supervisioning over the project evolution and report to the committee.

All the projects are expected to target some organization strategic goals, otherwise they are worthless and all the results are meaningless.


The _project management_ is the effort of an organization to fulfill the goals described through projects.

__Definition__. A _project_ is an initiative limited in time with precise goals and deadlines.  
__Definition__. A _program_ is a collection of interdependent projects whose combined results satisfy a prescribed goal.

__Definition__. _Portfolios_ are collections of projects and/or programs fulfilling the same strategy.


$$ \text{Portfolio} \supseteq \text{Program} \supseteq \text{Project} $$

### Psychology
Project management requires a lot of time and thinking; the success of a project depends from the active participation of all its members and the time they are spending must be carefully taken into consideration.
The __climate__ in the project team is very important; if the management is weak or there are unsolved conflicts then everybody will focus on her particular task without a long run analysis. That in turn generally leads to face more and more short-term, emergency issues leaving the big picture undefined and creating project halting breaks.

To avoid this situations, the climate can be improved leveraging on these factors:
 * organization culture
 * organization structure

__organization culture__ is about the best-practices and related tools used by the team to carry the effort on.
It also includes the attitude team members hold, try to be positive and collaborative.  
__organization structure__ is about the work relationships among the team members; each member must know who is in charge of what and who is expected to report to. More generally, roles and responsibilities must be clearly defined.  

### The client
Projects come seldom without a client, the final user demanding the project outcome.
The client satisfaction must be the focus of the project organization.
The client sets the project constraints:
 * costs
 * deadlines
 * quality

Clients should participate actively to the project processes so to avoid being stuck during development issues.

### Project tools
The following project management tools are methodologies to handle two key project aspects: risks and task scheduling.

__Risk management__. A risk is associated to one or more events whose happening can prevent a project from realizing its goals and, hence, decide its end. Each of these events can be associated with a happening probability (e.g., from 1=rare to 5=frequent) and a severity degree (e.g., from 1=mild to 5=catastrophic).

A risk can be related to the project realizability, to technical aspects or to project control procedures.

When a risk is identified with the list of triggering events and their associated probability and severity degrees, it can be placed in a risk matrix to evaluate its impact.

A risk matrix has on its rows the possible probabilities and on its column the severity degrees and risk analysts can define areas for which risks are considerable neglectable (e.g., probability from rare to probable with mild severity or rare probability with catastrophic severity).

The risks that are not in neglectable areas must be treated and risk analysts must specify how they intend to cover the project from these risks.
The treatments are devoted to reduce the probability or the severity of the risks and hence move the risk to the risk matrix neglectable area.
If it is not possible to treat a non-neglectable risk, then the project is considerable as failed.

__Task scheduling__. To achieve the project goals (or milestones) different, inter-connected activities are required. Activities are high-level tasks whose result is easily measurable. Their sequential or parallel fulfilling determines the project goal realization. Usually, activities are inter-dependent, so some of them can be executed in parallel while others must strictly follow sequentially some others.

The _project diagram_ is a horizontal sketch of the project activities specifying their inter relationships. The first (fictional) activity is the project beginning while the last one is the project end. The activities should be logically displayed so to connect the beginning with the end.
This diagram is popular during meeting as it stimulates team members to place questions and visualize their work inside the projects.

During this phase it is important not to consider the time nor the people who should fulfill the activities.

Each activity can be split in several tasks and each task into several sub-tasks.
The hierarchical representation of activities, tasks and sub-tasks is called _Work Breakdown Structure (WBS)_.

Workload must be distributed fairly among the team members, make sure each activity has a leader/responsible.
Each activity leader must provide a time-to-completion estimation of each task/sub-task; these estimations must be coherent (e.g., days) and they should include calendar off days (holidays, weekends, etc..).

Once we have the WBS and the task/sub-task completion time estimation we can compute and represent the float time with the PERT and the Gantt diagrams.

To create a PERT diagram, one can start from the project diagram and annotate the duration time of each activity.
One common way is to annotate to each block two information boxes, one related to duration, earliest possible beginning and earliest possible end and the second related to latest possible beginning, latest possible end and the resulting time float (latest possible beginning/end minus earliest possible beginning/end).
The first box can be filled in by navigating the project diagram from the beginning to the end; afterwards it is possible to navigate i backward to fill in the latter box.

The longest path in the PERT diagram in terms of duration summation is called the _critical path_ and it comprises of activities whose deadline cannot be easily postponed.
Such PERT diagram allows the manipulation of activities so to optimize the ending time and the float time.

With the information on activities duration and float time it is possible to create a Gantt diagram.
The Gantt gives a representation of activities temporal completion along with optional marks for milestones, releases and plenary meetings.

One good practice is to repeat the PERT/Gantt creation process for each individual activity on a task/sub-task basis. 

## Part 2 - Project Management 
It is important everybody uses the same management tools (including reporting and documentation standards) and follows the same procedures so to better understand each other and coordinating.

### Project life cycle
Project life, mutually exclusive, sequential phases:
 1. Presentation/Definition
 3. Planning
 4. Deploy and execution
 5. Closing

The committee is in charge to evaluate and approve each project phase at its conclusion.
A project phase cannot start if the committee has not approved the previous one.

### Presentation/Definition 
The major thing under analysis is the cost-benefit trade-off the new project implies.
It is suggested to hold a _kick-off_ meeting, featuring the sponsor, to gather all the stakeholders and present the project ideas.

At the end of this phase it must be clear:
 * who the sponsor and the project manager are 
 * who (candidate) team members are
 * who the other stakeholders are (people directly or indirectly affected by the project and people the project needs to get involved)
 * the project constraints
 * the project deliverables (expected outcomes)

Deliverables are especially important to give the project the form of a "_contract_" with the client.

The purpose of this phase is the logical organization of the information collected and the production of a project _brief_ document (a.k.a. executive summary).
The brief should include all the important information on the project: what, why, deadlines, constraints, risks and benefits.
The brief is usually one page long as it must be clear and concise.
It can optionally include the requirement specifications.

It is a good idea to create a list (or better a relationship diagram) of all the people involved in the project, with personal contacts and roles.
This list can be used as a reference to clarify the organization structure and it can be attached to correspondence.

A separate (secret) list can be created to keep track of stakeholders, with annotations on their positive or negative judgements on the project.

### Planning
The focus of this phase is on:
 * definition of the needed task, sub-tasks and their temporal scheduling.
 * setting of milestones
 * update of risk related documents (with all the needed treatments)

With the scheduling tools the project manager is required to iterate over and over to optimize the task scheduling meeting the deadline constraints.

Once we have information on the nature and the duration of each activity we can evaluate its direct and indirect costs.
Both the duration and the cost information is usually inserted into the WBS.

It is a good idea to assign each identified risk to a person working on a related activity, so that he can act as a whistle blower as the associated event manifests and he can monitor the state of the risk treatment.

During this phase milestones are also set on the Gantt diagrams.
Each milestone comes with the risk of not timely achieve it and that must be also taken into account by the risk management.
It is important to also define clearly which is the indicator of the project success and conclusion.

Several meeting types are needed: plenaries, problem-solving, on the advancements and with stakeholders.
It is advisable to schedule these meetings in advance in agreement with the team and the stakeholders.
Moreover, stakeholders expect periodic reporting on the project status, scheduling this kind of communication is suggested too.

The documents created in this phase constitute the _baseline_ and they must be preserved without modifications for a-posteriori evaluations.

### Deployment and execution
In this phase each activity leader receives the WBS with her work share and deadlines.
Usually this phases is started through a plenary meeting.

Communication is of main importance during execution; a suitable scheduling of what to say to who and when is needed, as well as a communication platform for success or issue feedbacks.

The project manager should Keep an updated list of:
 * Stakeholder list
 * Risk list

Stakeholders can decide the project fate with their support or they aversion and they can change opinion during time.
Hence, it is important to involve and control them.

Periodical control checks (e.g., one every month) are of paramount importance to grasp how the project is going and update if necessary the risk and stakeholder related documents.
The project manager main focus is on maintaining the baseline scheduling valid.
He should ask periodically to the activity leaders updates on the activity completion time estimation.

Sometimes bad, unexpected things can happen. 
A track of these events should be kept and an evaluation if a modification of the planning is needed performed.
If that is the case, modifications need to be approved by the sponsor and the client.
 
### Closing
Beware of the stakeholders that, close to the end of a project, ask for more modifications.
That leads to never-ending projects.
Also team members are less motivated as the project gets done and they look for the next project (or job) to take part of.
